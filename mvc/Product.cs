using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;

namespace projectsamozachet
{
    public partial class Product : Form
    {
        Facade facade;
        Form1 form1;
        MySqlConnection connection;
        MySqlCommand command;

        public Product(Facade facade, Form1 form1)
        {
            InitializeComponent();

            this.facade = facade;
            this.form1 = form1;
            this.connection = new MySqlConnection("server=127.0.0.1;username=root;password=root;database=restaurant");
            connect();
        }

        void connect()
        {
            init_view();
            data_reuse();
        }

        void init_view()
        {
            this.dgv_product.Columns.Add("id_product", "id_product");
            this.dgv_product.Columns.Add("name_product", "name_product");
            this.dgv_product.Columns.Add("price_1kg_rub", "price_1kg_rub");
        }

        void data_reuse()
        {
            this.dgv_product.Rows.Clear();
            List<List<string>> list_product = this.facade.product_list.get_list_client();
            foreach (List<string> product in list_product)
                dgv_product.Rows.Add(product[0], product[1], product[2]);
        }

        private void Product_FormClosed(object sender, FormClosedEventArgs e)
        {
            form1.Show();
        }

        private void button_insert_Click(object sender, EventArgs e)
        {
            int id_product = 1;
            if (this.dgv_product.Rows.Count > 0)
                id_product = Convert.ToInt32(this.dgv_product[this.dgv_product.Rows.Count - 1, 0].Value.ToString());
            string name_product = tb_name_product.Text;
            int price_1kg_rub = Convert.ToInt32(tb_price_1kg_rub.Text);
            /*if (el_is_valid(name_product, price_1kg_rub.ToString()) &&
                (!facade.product_list.get_list_id().Contains(id_product.ToString())))
            {*/
                Object[] list = { id_product, name_product, price_1kg_rub };
                facade.create_product_list(list);
                string insert_query = "INSERT INTO product(id_product, name_product, price_1kg_rub) " +
                    $"VALUES ({id_product}, \"{name_product}\", \"{price_1kg_rub}\")";
                executeMyQuery(insert_query);
            /*}*/
            data_reuse();
        }
        private void button_update_Click(object sender, EventArgs e)
        {
            int id_product = Convert.ToInt32(tb_id_product.Text);
            string name_product = tb_name_product.Text;
            int price_1kg_rub = Convert.ToInt32(tb_price_1kg_rub.Text);
            /*if (el_is_valid(name_product, price_1kg_rub.ToString()) &&
                (!facade.product_list.get_list_id().Contains(id_product.ToString())))
            {*/
                Object[] list = { id_product, name_product, price_1kg_rub };
                facade.update_product_list(list);
                string insert_query = string.Format("UPDATE product SET " +
                    "`id_product`={0}, `name_product`='{1}', `price_1kg_rub`={2} " +
                    "WHERE `id_product`={0}",
                    id_product.ToString(), name_product, price_1kg_rub.ToString());
                executeMyQuery(insert_query);
            /*}*/
            data_reuse();
        }

        private void button_delete_Click(object sender, EventArgs e)
        {
            facade.product_list.delete_el(Convert.ToInt32(tb_id_product.Text));
            string insert_query = string.Format("DELETE FROM `product` WHERE `id_product`={0}",
                Convert.ToInt32(tb_id_product.Text));
            executeMyQuery(insert_query);
            data_reuse();
        }

        private bool el_is_valid(string name_product, string price_1kg_rub)
        {
            bool flag = true;
            string regex = @"[0-9]{11}";
            if (!Regex.IsMatch(price_1kg_rub, regex))
                flag = false;
            if (name_product == "")
                flag = false;
            return flag;
        }

        public void executeMyQuery(string query)
        {
            try
            {
                openConnection();
                command = new MySqlCommand(query, connection);
                if (command.ExecuteNonQuery() == 1)
                {
                    execute_info.ForeColor = System.Drawing.Color.Green;
                    execute_info.Text = "Выполнено";
                }
                else
                {
                    execute_info.ForeColor = System.Drawing.Color.Red;
                    execute_info.Text = "Не выполнено";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                closeConnection();
            }
        }

        public void openConnection()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
        }

        public void closeConnection()
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();
        }
    }
}
