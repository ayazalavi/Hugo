package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class FAQ {
    @PrimaryKey
    public long id;

    public String question;

    public String answer;

    public FAQ(long id, String question, String answer) {
        this.id = id;
        this.question = question;
        this.answer = answer;
    }
}
