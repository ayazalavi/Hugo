package com.apps.client.juan.hugomed.data.entities;

public class Communication {
    public String api;
    public String videotoken;
    public String session;

    public Communication(String api, String videotoken, String session) {
        this.api = api;
        this.videotoken = videotoken;
        this.session = session;
    }
}
