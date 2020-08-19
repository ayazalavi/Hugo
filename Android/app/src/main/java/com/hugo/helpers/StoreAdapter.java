package com.hugo.helpers;

import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hugo.viewmodels.Store;
import com.hugo.databinding.HomeStoreCardBinding;
import com.hugo.views.SearchResult;
import com.hugo.views.StoreHome;

import java.util.List;


public class StoreAdapter extends RecyclerView.Adapter<StoreAdapter.ViewHolder> {

    private final List<Store> mValues;
    private Context ctx;

    public StoreAdapter(List<Store> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(final ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        HomeStoreCardBinding itemBinding = HomeStoreCardBinding.inflate(layoutInflater, parent, false);
        itemBinding.getRoot().setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(parent.getContext(), StoreHome.class);
                parent.getContext().startActivity(intent);
            }
        });
        return new ViewHolder(itemBinding);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        Store item = mValues.get(position);
        holder.bind(item, ctx);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final HomeStoreCardBinding binding;

        public ViewHolder(HomeStoreCardBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(Store item, Context context) {
            final int resourceId = context.getResources().getIdentifier(item.photo, "drawable", context.getPackageName());
            final int resourceId2 = context.getResources().getIdentifier(item.icon, "drawable", context.getPackageName());
            binding.brandPhoto.setImageDrawable(context.getResources().getDrawable(resourceId));
            binding.icon.setImageDrawable(context.getResources().getDrawable(resourceId2));
            binding.title.setText(item.name);
            binding.categories.setText(item.categories);
            binding.time.setText(item.time);
            binding.subtext.setText(item.subtext);
        }
    }
}