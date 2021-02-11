package com.apps.client.juan.hugomed.data.entities;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity(primaryKeys = {"id", "doctorID"})
public class Speciality {
    public long id;
    public String name;
    public String slug;
    public long doctorID;

    public Speciality(long id, String name, String slug, long doctorID) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.doctorID = doctorID;
    }
}
