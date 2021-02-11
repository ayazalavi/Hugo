package com.apps.client.juan.hugomed.data.entities;

public class Company_Tag {
    public int id;
    public String name;
    public  String description;
    public  boolean can_delete;
    public int users_count;
    public  boolean is_active;

    public Company_Tag(int id, String name, String description, boolean can_delete, int users_count, boolean is_active) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.can_delete = can_delete;
        this.users_count = users_count;
        this.is_active = is_active;
    }
}
