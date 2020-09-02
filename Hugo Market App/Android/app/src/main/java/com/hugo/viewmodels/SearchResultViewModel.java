package com.hugo.viewmodels;

import android.content.Context;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class SearchResultViewModel extends ViewModel {
    private Context ctx = null;
    private final MutableLiveData<List<Store>> searchStoreData = new MutableLiveData<List<Store>>();
    private final MutableLiveData<List<Product>> productListData = new MutableLiveData<List<Product>>();
    private final MutableLiveData<List<SearchResultFilter>> searchFilters = new MutableLiveData<List<SearchResultFilter>>();

    public void setContext(Context context) {
        this.ctx = context;
    }

    public LiveData<List<Store>> getSearchStoreData() {
        if (ctx != null) {
            List<Store> list = new ArrayList<Store>() {
                {
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                    add(new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5));
                }
            };
            searchStoreData.setValue(list);
        }
        return searchStoreData;
    }

    public LiveData<List<SearchResultFilter>> getSearchFilters() {
        if (ctx != null) {
            List<SearchResultFilter> list = new ArrayList<SearchResultFilter>() {
                {
                    add(new SearchResultFilter("Carnes"));
                    add(new SearchResultFilter("Promociones"));
                    add(new SearchResultFilter("Promociones"));
                    add(new SearchResultFilter("Carnes"));
                    add(new SearchResultFilter("Carnes"));
                    add(new SearchResultFilter("Carnes"));
                    add(new SearchResultFilter("Carnes"));
                    add(new SearchResultFilter("Carnes"));
                }
            };
            searchFilters.setValue(list);
        }
        return searchFilters;
    }

    public LiveData<List<Product>> getProductsData() {
        if (ctx != null) {
            List<Product> list = new ArrayList<Product>() {
                {
                    add(new Product("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon", "$4.90", 18));
                    add(new Product("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon", "$4.90", 18));
                    add(new Product("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon", "$4.90", 18));
                    add(new Product("product_brand_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon", "$4.90", 18));
                }
            };
            productListData.setValue(list);
        }
        return productListData;
    }

}
