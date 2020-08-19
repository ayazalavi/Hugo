package com.hugo.viewmodels;

import android.content.Context;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class HomeViewModel extends ViewModel {
    private Context ctx = null;
    private final MutableLiveData<HomeBanner> homeBannerData = new MutableLiveData<HomeBanner>();
    private final MutableLiveData<List<HomeBrand>> homeBrandData = new MutableLiveData<List<HomeBrand>>();
    private final MutableLiveData<List<HomeProduct>> homeProductData = new MutableLiveData<List<HomeProduct>>();
    private final MutableLiveData<List<HomeStore>> homeStoreData = new MutableLiveData<List<HomeStore>>();
    private final MutableLiveData<List<Store>> homeStoreBrandData = new MutableLiveData<List<Store>>();
    private final MutableLiveData<HashMap<String, List<Product>>> productCategoryData = new MutableLiveData<HashMap<String, List<Product>>>();

    public void setContext(Context context) {
        this.ctx = context;
    }

    public LiveData<HomeBanner> getHomeBannerData() {
        if (ctx != null) {
            HomeBanner banner = new HomeBanner("banner_photo", "El Clásico", "¡Todo lo que necesitás para vivir el mejor partido del mundo!");
            homeBannerData.setValue(banner);
        }
        return homeBannerData;
    }

    public LiveData<List<HomeBrand>> getHomeBrandData() {
        if (ctx != null) {
            List<HomeBrand> list = new ArrayList<HomeBrand>() {
                {
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                    add(new HomeBrand("brand_photo", "brand_icon", "Polo Raph Lauren", "RETAIL, MENSWEAR", "30 min", "Lorem Ipsum", false));
                }
            };
            homeBrandData.setValue(list);
        }
        return homeBrandData;
    }

    public LiveData<List<HomeProduct>> getHomeProductData() {
        if (ctx != null) {
            List<HomeProduct> list = new ArrayList<HomeProduct>() {
                {
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                    add(new HomeProduct("product_photo", "Summer Classic", "POLO"));
                }
            };
            homeProductData.setValue(list);
        }
        return homeProductData;
    }

    public LiveData<List<HomeStore>> getHomeStoreData() {
        if (ctx != null) {
            List<HomeStore> list = new ArrayList<HomeStore>() {
                {
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                    add(new HomeStore("store_photo", "hugo"));
                }
            };
            homeStoreData.setValue(list);
        }
        return homeStoreData;
    }

    public LiveData<List<Store>> getStoreBrandData() {
        if (ctx != null) {
            List<Store> list = new ArrayList<Store>() {
                {
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                    add(new Store ("store_brand_photo", "store_brand_icon", "Andían", "BISTRO-HEALTHY", "30 min", "Lorem Ipsum", "8AM-7PM", 4.5));
                }
            };
            homeStoreBrandData.setValue(list);
        }
        return homeStoreBrandData;
    }

    public LiveData<HashMap<String, List<Product>>> getProductCategoryData () {
        if (ctx != null) {
            final List<Product> list = new ArrayList<Product>() {
                {
                    add(new Product ("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                }
            };
            HashMap<String, List<Product>> hashMap = new HashMap<String, List<Product>>() {
                {
                    put("SPECIALTY COFFEE", new ArrayList<Product>(list));
                    put("ELECTRÓNICOS", new ArrayList<Product>(list));
                    put("PARA TUS MASCOTAS", new ArrayList<Product>(list));
                }
            };
            productCategoryData.setValue(hashMap);
        }
        return productCategoryData;
    }



}
