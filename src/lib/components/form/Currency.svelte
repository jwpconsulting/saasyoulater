<script lang="ts">
    const currencies: [string, string][] = [
        ["usd", "United States dollar ($)"],
        ["aud", "Australian dollar ($)"],
        ["eur", "Euro (€)"],
        ["inr", "Indian rupee (₹)"],
        ["jpy", "Japanese yen (¥)"],
        ["try", "Turkish lira (₺)"],
        ["uah", "Ukrainian hryvnia (₴)"],
        ["vnd", "Vietnamese dong (₫)"],
    ];
</script>

<div class="form-group">
    <label>Currency</label>
    <div>
        <select class="form-control">
            {#each currencies as [value, name]}
                <option {value}>{name}</option>
            {/each}
        </select>
    </div>
</div>
