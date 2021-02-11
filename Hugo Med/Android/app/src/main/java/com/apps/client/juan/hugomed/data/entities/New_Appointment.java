package com.apps.client.juan.hugomed.data.entities;

public class New_Appointment {
    public long place_id;
    public String type;
    public long doctor_id;
    public String patient_email;
    public String appointment_kind;
    public long service_id;
    public String motive;
    public  String status_list;
    public long company_id;
    public boolean is_ondemand;

    public New_Appointment(long place_id, String type, long doctor_id, String patient_email, String appointment_kind, long service_id, String motive, String status_list, long company_id, boolean is_ondemand) {
        this.place_id = place_id;
        this.type = type;
        this.doctor_id = doctor_id;
        this.patient_email = patient_email;
        this.appointment_kind = appointment_kind;
        this.service_id = service_id;
        this.motive = motive;
        this.status_list = status_list;
        this.company_id = company_id;
        this.is_ondemand = is_ondemand;
    }
}
