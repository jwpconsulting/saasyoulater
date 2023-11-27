<h1>SaaS You Later<small> - SaaS Business Model Calculator</small></h1>
<ul class="nav nav-tabs">
  <li class="active"><a href="#">Scenario 1</a></li>
  <li><a href="#">+ Add a Scenario</a></li>
</ul>
<div class="row">
  <div class="col-xs-6 col-md-2">
    <form>
      <h2>Controls</h2>
      <div class="form-group">
        <label class="control-label">Months</label><input
          type="number"
          class="form-control text-right"
          min="1"
          max="100"
          step="1"
        />
      </div>
      <div class="form-group">
        <label class="control-label">Churn Rate</label>
        <div class="input-group">
          <span class="input-group-addon">%</span><input
            type="number"
            class="form-control text-right"
            min="1"
            max="100"
            step="1"
          />
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">Customers at Start</label><input
          type="number"
          class="form-control text-right"
          min="10"
          max="1000"
          step="10"
        />
      </div>
      <div class="form-group">
        <label class="control-label">C. Growth MoM</label>
        <div class="input-group">
          <span class="input-group-addon">%</span><input
            type="number"
            class="form-control text-right"
            min="0"
            max="1000"
            step="10"
          />
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">Rev. per Customer</label>
        <div class="input-group">
          <span class="input-group-addon">$</span><input
            type="number"
            class="form-control text-right"
            min="0"
            max="1000"
            step="10"
          />
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">Gross Margin</label>
        <div class="input-group">
          <span class="input-group-addon">%</span><input
            type="number"
            class="form-control text-right"
            min="0"
            max="100"
            step="5"
          />
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">CAC</label>
        <div class="input-group">
          <span class="input-group-addon">$</span><input
            type="number"
            class="form-control text-right"
            min="0"
            max="5000"
            step="5"
          />
        </div>
      </div>
      <div class="form-group">
        <label class="control-label">Fixed Cost</label>
        <div class="input-group">
          <span class="input-group-addon">$</span><input
            type="number"
            class="form-control text-right"
            min="0"
            max="10000"
            step="100"
          />
        </div>
      </div>
    </form>
  </div>
  <div class="col-xs-6 col-md-3 col-md-push-7">
    <h2>Results</h2>
    <dl>
      <dt>EBIT positive</dt>
      <dd>At month <strong>7</strong></dd>
      <dt>Cumulative EBIT positive</dt>
      <dd>At month <strong>10</strong></dd>
      <dt>Average Customer Life</dt>
      <dd><strong>33</strong> months</dd>
      <dt>Customer Lifetime Value</dt>
      <dd><strong class="text-success">990</strong> $</dd>
      <dt>LTV over CAC</dt>
      <dd><span class="text-success">22</span></dd>
      <dt>Minimum Cumulative EBIT</dt>
      <dd><strong class="text-warning">-345</strong> $</dd>
    </dl>
    <h3>Options</h3>
    <div class="form-group">
      <label>Currency</label>
      <div>
        <select class="form-control"
          ><option value="usd">United States dollar ($)</option><option
            value="aud">Australian dollar ($)</option
          ><option value="eur">Euro (€)</option><option value="inr"
            >Indian rupee (₹)</option
          ><option value="jpy">Japanese yen (¥)</option><option value="try"
            >Turkish lira (₺)</option
          ><option value="uah">Ukrainian hryvnia (₴)</option><option value="vnd"
            >Vietnamese dong (₫)</option
          ></select
        >
      </div>
    </div>
    <div class="form-group">
      <label>Scenario Name</label><input
        class="form-control"
        placeholder="Scenario Name"
      />
    </div>
    <div class="form-group">
      <label>Comment</label><textarea
        class="form-control"
        placeholder="Scenario Comment"
      ></textarea>
    </div>
    <a href="#" class="btn btn-danger btn-xs btn-block">Delete Scenario</a>
  </div>
  <div class="col-xs-12 col-md-7 col-md-pull-3">
    <h2>Numbers</h2>
    <div class="table-responsive">
      <table class="table table-hover table-condensed">
        <thead
          ><tr
            ><th class="text-center">Month</th><th class="text-center"
              >Customers</th
            ><th class="text-center">Revenue</th><th class="text-center"
              >Gross Margin</th
            ><th class="text-center">Expenses</th><th class="text-center"
              >EBIT</th
            ><th class="text-center">Cumulative EBIT</th></tr
          ></thead
        ><tbody
          ><tr class="warning"
            ><td class="text-right">1</td><td class="text-right">10</td><td
              class="text-right"><strong class="text-success">300</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">150</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">235</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-85</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-85</strong> $</td
            ></tr
          ><tr class="warning"
            ><td class="text-right">3</td><td class="text-right">19</td><td
              class="text-right"><strong class="text-success">570</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">285</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">370</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-85</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-240</strong> $</td
            ></tr
          ><tr class="warning"
            ><td class="text-right">5</td><td class="text-right">35</td><td
              class="text-right"
              ><strong class="text-success">1050</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">525</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">550</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-25</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-335</strong> $</td
            ></tr
          ><tr class="warning"
            ><td class="text-right">7</td><td class="text-right">66</td><td
              class="text-right"
              ><strong class="text-success">1980</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">990</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">955</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">35</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-310</strong> $</td
            ></tr
          ><tr class="warning"
            ><td class="text-right">9</td><td class="text-right">124</td><td
              class="text-right"
              ><strong class="text-success">3720</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">1860</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">1720</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">140</strong> $</td
            ><td class="text-right"
              ><strong class="text-warning">-75</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">11</td><td class="text-right">233</td><td
              class="text-right"
              ><strong class="text-success">6990</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">3495</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">3160</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">335</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">460</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">14</td><td class="text-right">599</td><td
              class="text-right"
              ><strong class="text-success">17970</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">8985</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">7975</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">1010</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">2665</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">16</td><td class="text-right">1124</td><td
              class="text-right"
              ><strong class="text-success">33720</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">16860</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">14860</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">2000</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">6080</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">18</td><td class="text-right">2110</td><td
              class="text-right"
              ><strong class="text-success">63300</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">31650</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">27820</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">3830</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">12660</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">20</td><td class="text-right">3960</td><td
              class="text-right"
              ><strong class="text-success">118800</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">59400</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">52120</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">7280</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">25210</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">22</td><td class="text-right">7432</td><td
              class="text-right"
              ><strong class="text-success">222960</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">111480</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">97750</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">13730</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">48935</strong> $</td
            ></tr
          ><tr class="success"
            ><td class="text-right">24</td><td class="text-right">13950</td><td
              class="text-right"
              ><strong class="text-success">418500</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">209250</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">183385</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">25865</strong> $</td
            ><td class="text-right"
              ><strong class="text-success">93645</strong> $</td
            ></tr
          ></tbody
        >
      </table>
    </div>
  </div>
</div>
<hr />
<h2>Help</h2>
<div class="row">
  <div class="col-md-6">
    <h4>Explanation of Controls</h4>
    <dl>
      <dt>Months</dt>
      <dd>Length of business forecast</dd>
      <dt>Churn Rate</dt>
      <dd>Percentage of customers leaving monthly</dd>
      <dt>Customers at Start</dt>
      <dd>How many customers exist at start.</dd>
      <dt>Customer Growth Month over Month (MoM)</dt>
      <dd>
        Defines the monthly growth in percent, i.e., 3 % means your customer
        base will grow to 103% after a month.
      </dd>
      <dt>Revenue per customer</dt>
      <dd>Monthly revenue from one customer</dd>
      <dt>Gross Margin</dt>
      <dd>Difference between revenue and cost.</dd>
      <dd>
        <a href="https://en.wikipedia.org/wiki/Gross_margin"
          >Wikipedia Article</a
        >
      </dd>
      <dt>Customer Acquisition Cost (CAC)</dt>
      <dd>
        Customer Acquisition Cost is the cost associated in convincing a
        customer to subscribe to your SaaS. Typically this will be your
        marketing budget per customer.
      </dd>
      <dd>
        <a href="https://en.wikipedia.org/wiki/Customer_acquisition_cost"
          >Wikipedia Article</a
        >
      </dd>
      <dt>Fixed cost</dt>
      <dd>
        Business expenses that are not dependent on the amount of customers.
      </dd>
      <dd>
        <a href="https://en.wikipedia.org/wiki/Fixed_cost">Wikipedia Article</a>
      </dd>
    </dl>
  </div>
  <div class="col-md-6">
    <h4>Explanation of Results</h4>
    <dl>
      <dt>EBIT</dt>
      <dd>Earnings before interest and tax.</dd>
      <dd>
        <a
          href="https://en.wikipedia.org/wiki/Earnings_before_interest_and_taxes"
          >Wikipedia Article</a
        >
      </dd>
      <dt>EBIT positive</dt>
      <dd>
        Month at which EBIT cross 0. This will be the first month you make
        profit (before tax and interest)
      </dd>
      <dt>Cumulative EBIT positive</dt>
      <dd>
        Month at which cumulative EBIT cross 0. This will be the first month
        your SaaS businesses net worth is positive, not counting taxes and
        interest.
      </dd>
      <dt>Average Customer Lifetime</dt>
      <dd>Average number of months a customer stays with this business.</dd>
      <dt>Customer Lifetime Value</dt>
      <dd>
        Average revenue earned through one customer over the whole lifetime.
      </dd>
      <dt>LTV over CAC</dt>
      <dd>
        Ratio of Lifetime Value over Customer Acquisition Cost. Less than 1
        means acquisition will not yield in profit.
      </dd>
      <dt>Minimum Cumulative EBIT</dt>
      <dd>
        Lowest point in cumulative EBIT. Bank account needs to be able to
        shoulder this.
      </dd>
    </dl>
  </div>
</div>
<hr />
<p>
  Created by <a href="https://www.justus.pw">Justus Perlwitz</a> /
  <a href="mailto:hello@justus.pw">hello@justus.pw</a>
</p>
