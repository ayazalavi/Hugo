package com.apps.client.juan.hugomed.data.entities;

import android.graphics.drawable.Drawable;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity
public class Doctor {
    @PrimaryKey
    public long id;

    public String photoURL;

    public String name;

    public String category;

    public boolean isAvailable;

    public int availabilityMins;

    public double amount;

    @Ignore
    public Drawable picture;

    public Doctor(long id, String photoURL, String name, String category, boolean isAvailable, int availabilityMins, double amount) {
        this.id = id;
        this.photoURL = photoURL;
        this.name = name;
        this.category = category;
        this.isAvailable = isAvailable;
        this.availabilityMins = availabilityMins;
        this.amount = amount;
        this.picture = picture;
    }

    public void setAvailable() {
        this.isAvailable = true;
        this.availabilityMins = 0;
    }
}
