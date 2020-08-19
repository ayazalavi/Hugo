package com.hugo.viewmodels;


public final class HomeBrand {
    public String photo;
    public String icon;
    public String name;
    public String categories;
    public String time;
    public String subtext;

    public HomeBrand(String photo, String icon, String name, String categories, String time, String subtext, boolean isfavorite) {
        this.photo = photo;
        this.icon = icon;
        this.name = name;
        this.categories = categories;
        this.time = time;
        this.subtext = subtext;
        this.isfavorite = isfavorite;
    }

    boolean isfavorite;
}
