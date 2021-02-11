package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Junction;
import androidx.room.Relation;

import java.util.List;

public class DoctorWithSpecialities {
    @Embedded
    public Doctor doctor;
    @Relation(
            parentColumn = "doctorID",
            entityColumn = "doctorID"
    )
    public List<Speciality> specialities;
}
