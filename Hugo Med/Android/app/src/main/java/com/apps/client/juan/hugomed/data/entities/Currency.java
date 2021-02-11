package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Currency {
    @PrimaryKey  int id;
    String name;
    String logo;
    String symbol;
    String short_name;
    String description;
}
