using System;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace projectsamozachet
{
    public partial class Form1 : Form
    {
        Facade facade;
        MySqlConnection connection;

        public Form1()
        {
            InitializeComponent();

            this.facade = new Facade();
            this.connection = new MySqlConnection("server=127.0.0.1;username=root;password=root;database=restaurant");
            connect();
        }

        public Form1(Facade facade)
        {
            InitializeComponent();

            this.facade = facade;
            this.connection = new MySqlConnection("server=127.0.0.1;username=root;password=root;database=restaurant");
        }

        private void ingredient_Click(object sender, EventArgs e)
        {
            Ingredient ingredient = new Ingredient(facade, this);
            ingredient.Show();
            Hide();
        }

        private void dish_Click(object sender, EventArgs e)
        {
            Dish dish = new Dish(facade, this);
            dish.Show();
            Hide();
        }

        private void product_Click(object sender, EventArgs e)
        {
            Product product = new Product(facade, this);
            product.Show();
            Hide();
        }

        void connect()
        {
            string query = "SELECT * FROM product";
            DataTable table = new DataTable();
            MySqlDataAdapter adapter = new MySqlDataAdapter(query, connection);
            adapter.Fill(table);
            foreach (DataRow row in table.Rows)
                facade.create_product_list(row.ItemArray);
            query = "SELECT * FROM dish";
            table = new DataTable();
            adapter = new MySqlDataAdapter(query, connection);
            adapter.Fill(table);
            foreach (DataRow row in table.Rows)
                facade.create_dish_list(row.ItemArray);
            query = "SELECT * FROM ingredient";
            table = new DataTable();
            adapter = new MySqlDataAdapter(query, connection);
            adapter.Fill(table);
            foreach (DataRow row in table.Rows)
                facade.create_ingredient_list(row.ItemArray);
        }
    }
}
