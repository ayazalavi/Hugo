package com.apps.client.juan.hugomed.data.entities;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;

@Entity
public class Consultation {
    @PrimaryKey(autoGenerate = true)
    public long id;

    public long doctorID;

    public Date timeRequested;

    public Date timeCompleted;

    public ConsulationState state;

    public Consultation(long doctorID, Date timeRequested, Date timeCompleted, ConsulationState state) {
        this.id = id;
        this.doctorID = doctorID;
        this.timeRequested = timeRequested;
        this.timeCompleted = timeCompleted;
        this.state = state;
    }
}
