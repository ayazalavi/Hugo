package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Embedded;
import androidx.room.Relation;

public class ReceiptWithConsultation {
    @Embedded
    public Consultation consultation;
    @Relation(
            parentColumn = "id",
            entityColumn = "consulationID"
    )
    public Receipt receipt;
}
