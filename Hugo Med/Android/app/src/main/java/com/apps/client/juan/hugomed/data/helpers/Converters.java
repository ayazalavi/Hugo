package com.apps.client.juan.hugomed.data.helpers;

import androidx.room.TypeConverter;

import com.apps.client.juan.hugomed.data.entities.ConsulationState;

import java.util.Date;

public class Converters {
    @TypeConverter
    public static Date fromTimestamp(Long value) {
        return value == null ? null : new Date(value);
    }

    @TypeConverter
    public static Long dateToTimestamp(Date date) {
        return date == null ? null : date.getTime();
    }

    @TypeConverter
    public static ConsulationState toConsultationState(int value) {
        return ConsulationState.values()[value];
    }

    @TypeConverter
    public static int fromConsultationState(ConsulationState state) {
        return state.ordinal();
    }
}