package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;

@Entity
public class Appointment {
    @PrimaryKey
    public long id;
    public String code;
    public int doctor_id;
    @Embedded(prefix = "patient_") public Patient patient_ap_maker;
    public boolean is_ondemand;
    public String comms_session_id;
    public String appointment_kind;
    public  Date start_at_date;
    public  Date start_at_time;
    public  Date end_at_date;
    public  Date end_at_time;
    public  String motive;
    public  String state;
    public  String fee;
    public  String service_fee;
    public  String company_name;
    public  long appointment_origin;
    public  String paybalance_code;
    public  double paybalance_total;
    @Embedded(prefix = "currency_")
    public  Service.Currency currency;

    public Appointment(long id, String code, int doctor_id, Patient patient_ap_maker, boolean is_ondemand, String comms_session_id, String appointment_kind, Date start_at_date, Date start_at_time, Date end_at_date, Date end_at_time, String motive, String state, String fee, String service_fee, String company_name, long appointment_origin, String paybalance_code, double paybalance_total, Service.Currency currency) {
        this.id = id;
        this.code = code;
        this.doctor_id = doctor_id;
        this.patient_ap_maker = patient_ap_maker;
        this.is_ondemand = is_ondemand;
        this.comms_session_id = comms_session_id;
        this.appointment_kind = appointment_kind;
        this.start_at_date = start_at_date;
        this.start_at_time = start_at_time;
        this.end_at_date = end_at_date;
        this.end_at_time = end_at_time;
        this.motive = motive;
        this.state = state;
        this.fee = fee;
        this.service_fee = service_fee;
        this.company_name = company_name;
        this.appointment_origin = appointment_origin;
        this.paybalance_code = paybalance_code;
        this.paybalance_total = paybalance_total;
        this.currency = currency;
    }
}


