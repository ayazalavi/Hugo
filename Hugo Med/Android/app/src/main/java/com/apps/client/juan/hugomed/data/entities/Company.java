package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Company {
    @PrimaryKey
    public int id;

    @Embedded(prefix = "tag_") public Company_Tag tag;

    public int country;

}
