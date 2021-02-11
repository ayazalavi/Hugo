package com.apps.client.juan.hugomed.data.entities;

import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;

import androidx.room.ColumnInfo;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Junction;
import androidx.room.PrimaryKey;
import androidx.room.Relation;

import java.sql.Array;
import java.util.List;

@Entity
public class Doctor {
    @PrimaryKey
    @ColumnInfo(name = "doctorID")
    public long id;

    public String email;

    public String slug;

    public String get_full_name;

    public String avatar;

    public int country;

    public boolean on_demand;

    public String state;

    @Embedded public Waiting_time waiting_time;

    @Ignore
    public Speciality[] specialties;

    @Ignore
    public Drawable picture;

    public void setAvailable() {
        this.waiting_time.waiting = 0;
    }

}


