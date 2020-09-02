package com.hugo.viewmodels;

public final class HomeBanner {
    String photo;
    String title;
    String subtitle;

    public HomeBanner(String photo, String title, String subtitle) {
        this.photo = photo;
        this.title = title;
        this.subtitle = subtitle;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }
}
