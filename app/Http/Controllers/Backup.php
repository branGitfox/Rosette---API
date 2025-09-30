<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class Backup extends Controller
{

    public function backupDatabase()
    {
        // 1️⃣ Récupérer toutes les tables
        $tables = DB::select('SHOW TABLES');
        $dbName = env('DB_DATABASE');
        $tables = array_map(fn($table) => array_values((array)$table)[0], $tables);

        $backupSql = '';

        foreach ($tables as $table) {
            // 2️⃣ Supprimer la table si elle existe
            $backupSql .= "DROP TABLE IF EXISTS `$table`;\n";

            // 3️⃣ Structure de la table
            $createTable = DB::select("SHOW CREATE TABLE `$table`")[0];
            $createStmt = $createTable->{'Create Table'} ?? $createTable->Create_Table ?? null;
            if ($createStmt) {
                $backupSql .= $createStmt . ";\n\n";
            }

            // 4️⃣ Données de la table
            $rows = DB::table($table)->get();
            if ($rows->count() > 0) {
                foreach ($rows as $row) {
                    $rowArray = (array) $row;
                    $values = array_map(function ($value) {
                        return is_null($value) ? 'NULL' : '"' . addslashes($value) . '"';
                    }, $rowArray);

                    $backupSql .= "INSERT INTO `$table` VALUES(" . implode(',', $values) . ");\n";
                }
            }

            $backupSql .= "\n\n\n";
        }

        // 5️⃣ Sauvegarde du fichier
        $fileName = date('Y-m-d') . '.sql';
        $path = database_path("backups/$fileName");

        if (!File::exists(database_path('backups'))) {
            File::makeDirectory(database_path('backups'), 0755, true);
        }

        File::put($path, $backupSql);

        return "Backup créé : $path";
    }



    public function restoreDatabase(Request $request)
    {

        $filePath = base_path('database/backups/' . $request->db);

        if (!File::exists($filePath)) {
            return [
                'type' => 'error',
                'message' => "Fichier introuvable: $filePath"
            ];
        }

        $sql = '';
        $errors = '';

        try {

            DB::statement('SET FOREIGN_KEY_CHECKS=0;');

            $lines = file($filePath);

            foreach ($lines as $line) {

                if (substr($line, 0, 2) === '--' || trim($line) === '') {
                    continue;
                }

                $sql .= $line;


                if (substr(trim($line), -1) === ';') {
                    try {
                        DB::unprepared($sql);
                    } catch (\Exception $e) {
                        $errors .= $e->getMessage() . "\n";
                    }
                    $sql = '';
                }
            }
        } catch (\Exception $e) {
            return [
                'type' => 'error',
                'message' => "Erreur générale: " . $e->getMessage()
            ];
        } finally {

            DB::statement('SET FOREIGN_KEY_CHECKS=1;');
        }

        if ($errors) {
            return [
                'type' => 'error',
                'message' => $errors
            ];
        }

        return [
            'type' => 'success',
            'message' => 'Importation réussie 🎉'
        ];
    }

}
