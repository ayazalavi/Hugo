package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Relation;

public class PatientAppointment {
    @Embedded
    public Patient patient;
    @Relation(
            parentColumn = "id",
            entityColumn = "patient_ap_maker"
    )
    public Appointment appointment;
}
