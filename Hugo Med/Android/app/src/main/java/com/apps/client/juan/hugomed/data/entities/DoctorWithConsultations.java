package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;


public class DoctorWithConsultations {
    @Embedded
    public Doctor doctor;
    @Relation(
            parentColumn = "id",
            entityColumn = "doctorID"
    )
    public List<Consultation> consulations;
}

