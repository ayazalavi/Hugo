package com.hugo.helpers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.hugo.viewmodels.HomeStore;
import com.hugo.databinding.HomeStoreBinding;

import java.util.List;

public class HomeStoreAdapter extends RecyclerView.Adapter<HomeStoreAdapter.ViewHolder> {

    private final List<HomeStore> mValues;
    private Context ctx;

    public HomeStoreAdapter(List<HomeStore> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        HomeStoreBinding itemBinding = HomeStoreBinding.inflate(layoutInflater, parent, false);
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        HomeStore item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final HomeStoreBinding binding;

        public ViewHolder(HomeStoreBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(HomeStore item, Context context) {
            final int resourceId = context.getResources().getIdentifier(item.photo, "drawable", context.getPackageName());
            binding.icon.setImageDrawable(context.getResources().getDrawable(resourceId));
            binding.title.setText(item.title);
        }
    }
}