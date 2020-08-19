package com.hugo.viewmodels;

import android.content.Context;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class SearchViewModel extends ViewModel {
    private Context ctx = null;
    private final MutableLiveData<HashMap<String, List<SearchList>>> searchListData = new MutableLiveData<HashMap<String, List<SearchList>>>();
    private final MutableLiveData<HashMap<String, List<SearchList>>> searchResultData = new MutableLiveData<HashMap<String, List<SearchList>>>();

    public void setContext(Context context) {
        this.ctx = context;
    }

    public MutableLiveData<HashMap<String, List<SearchList>>> getSearchListData() {
        if (ctx != null) {
            HashMap<String, List<SearchList>> hashMap = new HashMap<String, List<SearchList>>() {
                {
                    put("RECOMENDADOS", new ArrayList<SearchList>() {
                        {
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                        }
                    });
                    put("MÁS RECIENTES", new ArrayList<SearchList>() {
                        {
                            add(new SearchList("search_icon_2","La esquina de Kurt", "Salud"));
                            add(new SearchList("search_icon_2","La esquina de Kurt", "Salud"));
                            add(new SearchList("search_icon_2","La esquina de Kurt", "Salud"));
                            add(new SearchList("search_icon_2","La esquina de Kurt", "Salud"));
                        }
                    });
                }
            };
            searchListData.setValue(hashMap);
        }
        return searchListData;
    }

    public LiveData<HashMap<String, List<SearchList>>> getSearchResultData() {
        if (ctx != null) {
            HashMap<String, List<SearchList>> hashMap = new HashMap<String, List<SearchList>>() {
                {
                    put("RESULTADO DE BÚSQUEDA", new ArrayList<SearchList>() {
                        {
                            add(new SearchList("search_icon_1", "Supermercado", "Categoria"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                            add(new SearchList("search_icon_1", "Alitas", "Comida"));
                        }
                    });
                }
            };
            searchResultData.setValue(hashMap);
        }
        return searchResultData;
    }

}
