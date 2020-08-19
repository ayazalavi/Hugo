package com.hugo.helpers;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.databinding.BindingAdapter;
import androidx.recyclerview.widget.RecyclerView;

import com.hugo.databinding.HomeStoreCardBinding;
import com.hugo.databinding.SearchListItemBinding;
import com.hugo.viewmodels.SearchList;
import com.hugo.viewmodels.Store;
import com.hugo.views.Search;
import com.hugo.views.SearchResult;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class SearchAdapter extends RecyclerView.Adapter<SearchAdapter.ViewHolder> {

    public HashMap<String, List<SearchList>> mValues;
    private Context ctx;

    public SearchAdapter(HashMap<String, List<SearchList>> items, Context context) {
        mValues = items;
        this.ctx = context;


    }

    @Override
    public void onAttachedToRecyclerView(@NonNull RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);

    }

    @Override
    public ViewHolder onCreateViewHolder(final ViewGroup parent, int viewType) {

        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        SearchListItemBinding itemBinding = SearchListItemBinding.inflate(layoutInflater, parent, false);
        itemBinding.getRoot().setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(parent.getContext(), SearchResult.class);
                parent.getContext().startActivity(intent);
            }
        });
        return new ViewHolder(itemBinding, this.ctx);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        //Store item = mValues.get(position);
        int itemPosition = -1;
        for (Map.Entry<String, List<SearchList>> entry: mValues.entrySet()) {
            itemPosition++;
            if (itemPosition == position) {
                holder.bind(entry.getKey(), ctx);
                return;
            }
            List<SearchList> list = entry.getValue();
            for (SearchList entry2: list) {
                itemPosition++;
                if (itemPosition == position) {
                    holder.bind(entry2, ctx);
                    return;
                }
            }
        }

    }

    @Override
    public int getItemCount() {
        int count = 0;
        for (Map.Entry<String, List<SearchList>> entry: mValues.entrySet()) {
            count += entry.getValue().size() + 1;
        }
        return count;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        private final SearchListItemBinding binding;
        private static Context ctx;

        public ViewHolder(SearchListItemBinding binding, Context context) {
            super(binding.getRoot());
            this.binding = binding;
            this.ctx = context;
        }

        public void bind(SearchList item, Context context) {
            this.binding.setIsTitle(false);
            this.binding.setSearch(item);
        }

        public void bind(String item, Context context) {
            this.binding.setIsTitle(true);
            this.binding.setTitle(item);
        }

        @BindingAdapter("android:src")
        public static void setImageUri(ImageView view, String imageName) {
            try {
                if (imageName == null) {
                    return;
                }
                final int resourceId = view.getResources().getIdentifier(imageName, "drawable", view.getContext().getPackageName());
                view.setImageDrawable(view.getResources().getDrawable(resourceId));
            }
            catch (Exception exception) {
                Log.d("tag", exception.getStackTrace().toString());
            }
        }
    }
}