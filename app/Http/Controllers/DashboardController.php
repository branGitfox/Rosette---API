<?php

namespace App\Http\Controllers;

use App\Models\Acs;
use App\Models\Depensesparmois;
use App\Models\Droits;
use App\Models\Ecolages;
use App\Models\Kermesses;
use App\Models\Moins;
use App\Models\Ajouts;
use App\Models\Revenusparmois;
use Error;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function getBarData(){

        $ac_id =request()->query('year')=='last'? Acs::latest()->first()->id:request()->query('year');
        $start = request()->query('start');
        $end = request()->query('end');
        // --- REVENUS ---
        $revenus_janv = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-01-'."%")->period($start, $end)->get() as $r) {
            $revenus_janv += $r->solde;
        }

        $revenus_fev = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-02-'."%")->period($start, $end)->get() as $r) {
            $revenus_fev += $r->solde;
        }

        $revenus_mar = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-03-'."%")->period($start, $end)->get() as $r) {
            $revenus_mar += $r->solde;
        }

        $revenus_avr = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-04-'."%")->period($start, $end)->get() as $r) {
            $revenus_avr += $r->solde;
        }

        $revenus_mai = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-05-'."%")->period($start, $end)->get() as $r) {
            $revenus_mai += $r->solde;
        }

        $revenus_jun = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-06-'."%")->period($start, $end)->get() as $r) {
            $revenus_jun += $r->solde;
        }

        $revenus_jui = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-07-'."%")->period($start, $end)->get() as $r) {
            $revenus_jui += $r->solde;
        }

        $revenus_aou = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-08-'."%")->period($start, $end)->get() as $r) {
            $revenus_aou += $r->solde;
        }

        $revenus_sep = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-09-'."%")->period($start, $end)->get() as $r) {
            $revenus_sep += $r->solde;
        }

        $revenus_oct = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-10-'."%")->period($start, $end)->get() as $r) {
            $revenus_oct += $r->solde;
        }

        $revenus_nov = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-11-'."%")->period($start, $end)->get() as $r) {
            $revenus_nov += $r->solde;
        }

        $revenus_dec = 0;
        foreach (Revenusparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-12-'."%")->period($start, $end)->get() as $r) {
            $revenus_dec += $r->solde;
        }

        // --- DEPENSES ---
        $depenses_janv = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-01-'."%")->period($start, $end)->get() as $d) {
            $depenses_janv += $d->solde;
        }

        $depenses_fev = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-02-'."%")->period($start, $end)->get() as $d) {
            $depenses_fev += $d->solde;
        }

        $depenses_mar = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-03-'."%")->period($start, $end)->get() as $d) {
            $depenses_mar += $d->solde;
        }

        $depenses_avr = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-04-'."%")->period($start, $end)->get() as $d) {
            $depenses_avr += $d->solde;
        }

        $depenses_mai = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-05-'."%")->period($start, $end)->get() as $d) {
            $depenses_mai += $d->solde;
        }

        $depenses_jun = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-06-'."%")->period($start, $end)->get() as $d) {
            $depenses_jun += $d->solde;
        }

        $depenses_jui = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-07-'."%")->period($start, $end)->get() as $d) {
            $depenses_jui += $d->solde;
        }

        $depenses_aou = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-08-'."%")->period($start, $end)->get() as $d) {
            $depenses_aou += $d->solde;
        }

        $depenses_sep = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-09-'."%")->period($start, $end)->get() as $d) {
            $depenses_sep += $d->solde;
        }

        $depenses_oct = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-10-'."%")->period($start, $end)->get() as $d) {
            $depenses_oct += $d->solde;
        }

        $depenses_nov = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-11-'."%")->period($start, $end)->get() as $d) {
            $depenses_nov += $d->solde;
        }

        $depenses_dec = 0;
        foreach (Depensesparmois::where('ac_id', $ac_id)->where('mois','like', date('y').'-12-'."%")->period($start, $end)->get() as $d) {
            $depenses_dec += $d->solde;
        }

        // Regroupement
        $revenus_traite = [
            $revenus_janv, $revenus_fev, $revenus_mar, $revenus_avr,
            $revenus_mai, $revenus_jun, $revenus_jui, $revenus_aou,
            $revenus_sep, $revenus_oct, $revenus_nov, $revenus_dec,
        ];

        $depenses_traite = [
            $depenses_janv, $depenses_fev, $depenses_mar, $depenses_avr,
            $depenses_mai, $depenses_jun, $depenses_jui, $depenses_aou,
            $depenses_sep, $depenses_oct, $depenses_nov, $depenses_dec,
        ];

        $status = [];

        for($i=0; $i< count($revenus_traite); $i++) {
            array_push($status, $revenus_traite[$i] - $depenses_traite[$i]);
        }
        return response()->json([
            'revenus' => $revenus_traite,
            'depenses' => $depenses_traite,
            'status' => $status,

        ]);
    }


    //RECUPERATION DERNIER DEBIT ET CREDIT
    public function getFlux() {
        $last_debit = Revenusparmois::latest()->first();
        $last_credit = Depensesparmois::latest()->first();

        return response()->json([
            'debit' => $last_debit->solde??0,
            'credit' => $last_credit->solde,
        ]);

    }

    //DEPOT D'ARGENT
    public function plus(Request $request, EcolageController $ecolage, KermessesController $kermesse, DroitsController $droit, RevenusMoisController $revenusmois, AuditsController $audit){
        $ac_id = Acs::latest()->first()->id;
        $ecolage->increment($ac_id, $request->ecolage);
        $kermesse->increment($ac_id, $request->kermesse);
        $droit->increment($ac_id, $request->droit);
        $motif = $request->motif;
        Ajouts::create(['motif' => $motif, 'ecolage' =>  $request->ecolage, 'droit' => $request->droit, 'kermesse' =>  $request->kermesse, 'ac_id' => $ac_id]);
        $revenusmois->increment($ac_id, date('y-m-d'),($request->ecolage+$request->droit+$request->kermesse));
        $message = "Depot d'argent";
        $audit->listen('Financier', $message, $request->user()->id);
        return response()->json(['message' => 'Opération reussi']);
    }

    //RETIRER DE L'ARGENT
    public function moins(Request $request, EcolageController $ecolage, KermessesController $kermesse, DroitsController $droit, DepensesMoisController $depensesmois, AuditsController $audit){
        $ac_id = Acs::latest()->first()->id;
        $solde_ecolage = Ecolages::where('ac_id', $ac_id)->first()->solde;
        $solde_droit = Droits::where('ac_id', $ac_id)->first()->solde;
        $solde_kermesse = Kermesses::where('ac_id', $ac_id)->first()->solde;

        if($request->ecolage !=0&&$request->ecolage > $solde_ecolage){
            throw new Error('Solde d\'ecolage insuffisant');
        }

        if($request->droit != 0&&$request->droit > $solde_droit){
            throw new Error('Solde de droit insuffisant');
        }

        if($request->kermesse!= 0 &&$request->kermesse> $solde_kermesse){
            throw new Error('Solde de kermesse insuffisant');
        }
        $ecolage->decrement($ac_id, $request->ecolage);
        $kermesse->decrement($ac_id, $request->kermesse);
        $droit->decrement($ac_id, $request->droit);
        $motif = $request->motif;
        Moins::create(['motif' => $motif, 'ecolage' =>  $request->ecolage, 'droit' => $request->droit, 'kermesse' =>  $request->kermesse, 'ac_id' => $ac_id]);
        $depensesmois->increment($ac_id, date('y-m-d'),($request->ecolage+$request->droit+$request->kermesse));
        $message = "Retrait d'argent";
        $audit->listen('Financier', $message, $request->user()->id);
        return response()->json(['message' => 'Opération reussi']);
    }

    public function moins_list (){
        $list = [];
        foreach (Moins::query()->orderByDesc('created_at')->get() as $moins){
            array_push($list, ['id' => $moins['id'], 'motif' => $moins['motif'], 'ops' => [
                [
                'type' => 'écolage',
                'montant' => $moins['ecolage']
                    ],
                [
                    'type' => 'droit',
                    'montant' => $moins['droit']
                ],
                [
                    'type' => 'kermesse',
                    'montant' => $moins['kermesse']
                ]
            ]]);
        }

        return response()->json($list);
    }

    public function plus_list (){
        $list = [];
        foreach (Ajouts::query()->orderByDesc('created_at')->get() as $moins){
            array_push($list, ['id' => $moins['id'], 'motif' => $moins['motif'], 'ops' => [
                [
                    'type' => 'écolage',
                    'montant' => $moins['ecolage']
                ],
                [
                    'type' => 'droit',
                    'montant' => $moins['droit']
                ],
                [
                    'type' => 'kermesse',
                    'montant' => $moins['kermesse']
                ]
            ]]);
        }

        return response()->json($list);
    }
}
