package com.hugo.helpers;

import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hugo.viewmodels.HomeBrand;
import com.hugo.databinding.HomeBrandCardBinding;
import com.hugo.views.StoreHome;

import java.util.List;

public class BrandAdapter extends RecyclerView.Adapter<BrandAdapter.ViewHolder> {

    private final List<HomeBrand> mValues;
    private Context ctx;

    public BrandAdapter(List<HomeBrand> items, Context context) {
        mValues = items;
        this.ctx = context;
    }

    @Override
    public ViewHolder onCreateViewHolder(final ViewGroup parent, int viewType) {
        LayoutInflater layoutInflater = LayoutInflater.from(parent.getContext());
        HomeBrandCardBinding itemBinding = HomeBrandCardBinding.inflate(layoutInflater, parent, false);
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
        HomeBrand item = mValues.get(position);
        holder.bind(item, ctx);

    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private final HomeBrandCardBinding binding;

        public ViewHolder(HomeBrandCardBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        public void bind(HomeBrand item, Context context) {
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