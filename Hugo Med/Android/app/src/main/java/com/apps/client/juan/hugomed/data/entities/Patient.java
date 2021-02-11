package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;

@Entity
public class Patient {
    @PrimaryKey
    public long id;

    public String first_name;

    public String last_name;

    public String email;

    public long country_id;

    public  Date date_of_birth;

    public   Date created_at;

    public  String state;

    public Patient(long id, String first_name, String last_name, String email, long country_id, Date date_of_birth, Date created_at, String state) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.country_id = country_id;
        this.date_of_birth = date_of_birth;
        this.created_at = created_at;
        this.state = state;
    }
}
