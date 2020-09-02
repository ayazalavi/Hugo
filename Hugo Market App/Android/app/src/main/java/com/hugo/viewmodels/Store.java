package com.hugo.viewmodels;

public final class Store {
    public String photo, icon, name, categories, time, subtext, openTimings;
    public double ratings;

    public Store(String photo, String icon, String name, String categories, String time, String subtext, String openTimings, double ratings) {
        this.photo = photo;
        this.icon = icon;
        this.name = name;
        this.categories = categories;
        this.time = time;
        this.subtext = subtext;
        this.openTimings = openTimings;
        this.ratings = ratings;
    }
}
