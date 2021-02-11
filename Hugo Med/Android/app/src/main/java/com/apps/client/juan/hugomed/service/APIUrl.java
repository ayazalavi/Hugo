package com.apps.client.juan.hugomed.service;

public class APIUrl {

    private static boolean production = false;
    public static String api_host = production ? "https://api.aliv.io" : "http://test-api.aliv.io";
    public static String API_KEY = "UwF7j4gj.WYTKstv0lvhqXPr2kuVmLzP8OerkPpRj";


    public static String url(MED_API_URL url) {
        switch (url) {
            case GET_PATIENT_BY_ID:
                return api_host+Endpoints.PATIENTS.toString() + "?id="+url.param1;
            case GET_COMPANY_CATALOG:
                return api_host+Endpoints.COMPANIES.toString() + "?country="+url.param1;
            case GET_DOCTORS_BY_MICROUNIVERSE:
                return api_host+Endpoints.DOCTORS.toString() + "?company="+url.param1;
            case GET_DOCTOR_BY_ID:
                return api_host+Endpoints.DOCTORS.toString() + "/"+url.param1;
            case GET_DOCTOR_SERVICES:
                return api_host+Endpoints.SERVICES.toString() + "?id="+url.param1;
            case REGISTER_ON_DEMAND_APPOINTMENT:
                return api_host+Endpoints.APPOINTMENTS.toString()+"/";
            case GET_PATIENT_APPOINTMENT:
                return api_host+Endpoints.APPOINTMENTS.toString() + "?patient_id="+url.param1;
            case GET_COMM_KEYS_APPOINTMENT:
                return api_host+Endpoints.APPOINTMENTS.toString() + "/comm_keys?code="+url.param1;
            default:
                return "";
        }
    }

    enum Endpoints {
         PATIENTS {
             public String toString() {
                 return "/users/patients";
             }
         },
         COMPANIES {
             public String toString() {
                 return "/companies";
             }
         },
         DOCTORS {
            public String toString() {
                return "/users/doctors";
            }
        },
         SERVICES{
             public String toString() {
                 return "/services";
             }
         },
         APPOINTMENTS{
             public String toString() {
                 return "/appointments";
             }
         }
    }
}

