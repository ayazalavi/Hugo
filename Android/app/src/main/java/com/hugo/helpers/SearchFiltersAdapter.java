package com.hugo.helpers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.hugo.databinding.HomeStoreBinding;
import com.hugo.databinding.SearchFilterBinding;
import com.hugo.viewmodels.HomeStore;
import com.hugo.viewmodels.SearchResultFilter;

import java.util.List;

public class SearchFiltersAdapter extends RecyclerView.Adapter<SearchFiltersAdapter.ViewHolder> {

    private final List<SearchResultFilter> mValues;
    private Context ctx;

    public SearchFiltersAdapter(List<SearchResultFilter> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        SearchFilterBinding itemBinding = SearchFilterBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        SearchResultFilter item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final SearchFilterBinding binding;

        public ViewHolder(SearchFilterBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(SearchResultFilter item, Context context) {
            this.binding.setFilter(item);
        }
    }
}