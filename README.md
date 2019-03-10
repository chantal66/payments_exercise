# Payments Exercise  [![Build Status](https://travis-ci.org/chantal66/payments_exercise.svg?branch=master)](https://travis-ci.org/chantal66/payments_exercise)

## Overview

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

### How to Get Started

 This project runs on `ruby 2.5.3` and `rails 5.2.2`
 
1. Clone the repo in your terminal:
 ```
 $ git clone https://github.com/chantal66/payments_exercise.git
 ```
2. Navigate into the project: 
```
$ cd payments_exercise
```

3. Bundle:
``` 
$ bundle install
```
4. Create, migrate, and seed your database: 
``` 
$ rake db:{migrate,seed}
```

5. Run `rspec` in your terminal to ensure all tests are passing.

## Endpoints
You can visit these endpoints to see a JSON response.

#### Loans

In your terminal, start a local server: `rails s`

Open your browser to `localhost:3000`

- `/loans` returns a list of loans
- `/loans/:id` returns a specific loan based on the id

| Parameter | Description |
| --- | --- |
| id | loan ID |
| funded_amount | amount of money provided to a given user |
| outstanding_balance | amount owned by a given user |
| created_at | created_at timestamp |
| updated_at | updated_at timestamp |

#### Payments

- `/payments` returns a list of payments
- `/payments/:id` returns a specific payments based on the id

| Parameter | Description |
| --- | --- |
| id | payment ID |
| loan_id | loan ID |
| payment_date | Date when the payment was received |
| payment_amount | amount paid |
| created_at | created_at timestamp |
| updated_at | updated_at timestamp |