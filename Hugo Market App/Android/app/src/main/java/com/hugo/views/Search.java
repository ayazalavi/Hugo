package com.hugo.views;

import android.os.Bundle;

import com.hugo.R;
import com.hugo.helpers.HugoList;
import com.hugo.helpers.SearchAdapter;
import com.hugo.viewmodels.SearchList;
import com.hugo.viewmodels.SearchViewModel;
import com.hugo.databinding.ActivitySearchBinding;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;

import java.util.HashMap;
import java.util.List;

public class Search extends AppCompatActivity implements Navigation.OnActivityCreated {

    private ActivitySearchBinding activitySearchBinding;
    private SearchViewModel model;
    private FragmentTransaction fragmentTransaction;
    private HugoList searchList;
    private Navigation navigation;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        activitySearchBinding = ActivitySearchBinding.inflate(getLayoutInflater());
        View view = activitySearchBinding.getRoot();
        setContentView(view);

        model = new ViewModelProvider(this).get(SearchViewModel.class);
        model.setContext(this);

        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentTransaction = fragmentManager.beginTransaction();
        addNavigation();
        addSearchList();
        fragmentTransaction.commit();


    }

    @Override
    public void setNavigation() {
        navigation.setNavigationSettings(new Navigation.NavigationSettings("EXPLORAR", R.style.AppTheme_NavigationTitleSearch, true, R.drawable.back_icon_top_bar, false , 0));
        navigation.setSearchBarFocus(true);
        navigation.setSearchBarClickListner(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        }, true);

        navigation.setSearchBarHitEnterListner(new View.OnKeyListener() {

            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if (keyCode == 66) {
                    model.getSearchListData().setValue(model.getSearchResultData().getValue());
                }
                return false;
            }
        }, new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                int length = s.length();
                if (length == 0) {
                    model.getSearchListData().setValue(model.getSearchListData().getValue());
                }
            }
        });


    }

    private void addNavigation() {
        navigation = new Navigation();
        fragmentTransaction.add(R.id.search_scrollview, navigation); //
    }


    private void addSearchList() {
        searchList = new HugoList();
        fragmentTransaction.add(R.id.search_scrollview, searchList);

        model.getSearchListData().observe(this, new Observer<HashMap<String, List<SearchList>>>() {
            private SearchAdapter adapter;

            @Override
            public void onChanged(HashMap<String, List<SearchList>> stringListHashMap) {
                searchList.hideTitle();
                searchList.hideViewMore();
                searchList.makeListVertical();
                if (adapter == null) {
                    adapter = new SearchAdapter(stringListHashMap, Search.this);
                    searchList.setDataAdapter(adapter);
                }
                else {
                    adapter.mValues = stringListHashMap;
                    adapter.notifyDataSetChanged();
                }
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        //getMenuInflater().inflate(R.menu.menu_home, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_home) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void goBack(View view) {
        finish();

    }
}