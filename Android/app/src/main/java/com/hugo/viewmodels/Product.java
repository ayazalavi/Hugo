package com.hugo.viewmodels;

import android.text.SpannableString;

public final class Product {
    public String photo, title, subtitle, icon, price;
    public int ageLimit;
    public SpannableString titleThemed;

    public Product(String photo, String title, String subtitle, String icon, String price, int ageLimit) {
        this.photo = photo;
        this.title = title;
        this.subtitle = subtitle;
        this.icon = icon;
        this.price = price;
        this.ageLimit = ageLimit;
        this.titleThemed = null;
    }

}
