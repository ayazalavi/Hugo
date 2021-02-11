package com.apps.client.juan.hugomed.data.entities;

public class Appointment_Response {
    public boolean response;
    public String code;
    public String datetime;

    public Appointment_Response(boolean response, String code, String datetime) {
        this.response = response;
        this.code = code;
        this.datetime = datetime;
    }
}
