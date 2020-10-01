package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Receipt {

    @PrimaryKey(autoGenerate = true)
    public long id;

    public String transactionID;

    public String service;

    public long consulationID;

    public Receipt(String transactionID, String service, long consulationID) {
        this.id = id;
        this.transactionID = transactionID;
        this.service = service;
        this.consulationID = consulationID;
    }
}
