create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null,
    category varchar(255) not null,
    aisle_id int not null,
    price decimal(10,2) not null,
    quantity int not null,
    restock_interval int not null,
    last_restock_date date not null,
    next_restock_date date not null,
    supplier_id int not null,
    foreign key (supplier_id) references suppliers(supplier_id),
    foreign key (aisle_id) references aisles(aisle_id),
    CONSTRAINT price_check CHECK (price >= 0),
    CONSTRAINT quantity_check CHECK (quantity >= 0),
    CONSTRAINT restock_interval_check CHECK (restock_interval > 0),
    CONSTRAINT next_restock_date_check CHECK (next_restock_date > last_restock_date)
);
