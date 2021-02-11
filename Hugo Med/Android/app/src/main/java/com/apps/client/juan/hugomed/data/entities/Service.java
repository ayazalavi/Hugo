package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity
public class Service {
    @PrimaryKey
    public int id;

    public String name;

    public String description;

    public String fee;

    public int doctor;

    @Embedded(prefix = "currency_") public Currency currency;

    public Service(int id, String name, String description, String fee, int doctor, Currency currency) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.fee = fee;
        this.doctor = doctor;
        this.currency = currency;
    }

    class Currency {
        public int id;
        public String name;
        public String logo;
        public String symbol;
        public String short_name;

        public Currency(int id, String name, String logo, String symbol, String short_name, String description) {
            this.id = id;
            this.name = name;
            this.logo = logo;
            this.symbol = symbol;
            this.short_name = short_name;
            this.description = description;
        }

        public String description;
    }
    public Double getFee() {
        return Double.parseDouble(fee);
    }
}

