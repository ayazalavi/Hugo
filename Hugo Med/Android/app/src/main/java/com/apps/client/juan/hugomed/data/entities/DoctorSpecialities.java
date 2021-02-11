package com.apps.client.juan.hugomed.data.entities;


import androidx.room.ColumnInfo;
import androidx.room.Entity;

@Entity(primaryKeys = {"doctorID", "specialityID"})
public class DoctorSpecialities {
    public long doctorID;
    @ColumnInfo(index = true)
    public long specialityID;
}
