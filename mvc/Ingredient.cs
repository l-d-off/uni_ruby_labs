using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


namespace projectsamozachet
{
    public partial class Ingredient : Form
    {
        Facade facade;
        Form1 form1;
        MySqlConnection connection;
        MySqlCommand command;

        public Ingredient(Facade facade, Form1 form1)
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
            this.dgv_ingredient.Columns.Add("id_ingredient", "id_ingredient");
            this.dgv_ingredient.Columns.Add("id_dish", "id_dish");
            this.dgv_ingredient.Columns.Add("id_product", "id_product");
            this.dgv_ingredient.Columns.Add("gram_in_product", "gram_in_product");
        }

        void data_reuse()
        {
            this.dgv_ingredient.Rows.Clear();
            List<List<string>> list_ingredient = this.facade.ingredient_list.get_list_client();
            foreach (List<string> ingredient in list_ingredient)
                dgv_ingredient.Rows.Add(ingredient[0], ingredient[1], ingredient[2], ingredient[3]);
        }

        private void Ingredient_FormClosed(object sender, FormClosedEventArgs e)
        {
            form1.Show();
        }

        private void button_insert_Click(object sender, EventArgs e)
        {
            int id_ingredient = 1;
            if (this.dgv_ingredient.Rows.Count > 0)
                id_ingredient = Convert.ToInt32(this.dgv_ingredient[this.dgv_ingredient.Rows.Count - 1, 0].Value.ToString());
            int id_dish = Convert.ToInt32(tb_id_dish.Text);
            int id_product = Convert.ToInt32(tb_id_product.Text);
            int gram_in_product = Convert.ToInt32(tb_gram_in_product.Text);
            /*if (el_is_valid(name_dish, price_1kg_rub.ToString()) &&
                (!facade.dish_list.get_list_id().Contains(id_dish.ToString())))
            {*/
            Object[] list = { id_ingredient, id_dish, id_product, gram_in_product };
            facade.create_ingredient_list(list);
            string insert_query = "INSERT INTO ingredient(id_ingredient, id_dish, id_product, " +
                "gram_in_product) VALUES " +
                $"({id_ingredient}, {id_dish}, {id_product}, \"{gram_in_product}\")";
            executeMyQuery(insert_query);
            /*}*/
            data_reuse();
        }
        private void button_update_Click(object sender, EventArgs e)
        {
            int id_ingredient = Convert.ToInt32(tb_id_ingredient.Text);
            int id_dish = Convert.ToInt32(tb_id_dish.Text);
            int id_product = Convert.ToInt32(tb_id_product.Text);
            int gram_in_product = Convert.ToInt32(tb_gram_in_product.Text);
            /*if (el_is_valid(name_dish, price_1kg_rub.ToString()) &&
                (!facade.dish_list.get_list_id().Contains(id_dish.ToString())))
            {*/
            Object[] list = { id_ingredient, id_dish, id_product, gram_in_product };
            facade.update_ingredient_list(list);
            string insert_query = string.Format("UPDATE ingredient SET " +
                "`id_ingredient`={0}, `id_dish`={1}, `id_product`={2}, " +
                "`gram_in_product`={3} " +
                "WHERE `id_ingredient`={0}",
                id_ingredient.ToString(), id_dish.ToString(), id_product.ToString(),
                gram_in_product.ToString());
            executeMyQuery(insert_query);
            /*}*/
            data_reuse();
        }

        private void button_delete_Click(object sender, EventArgs e)
        {
            facade.dish_list.delete_el(Convert.ToInt32(tb_id_dish.Text));
            string insert_query = string.Format("DELETE FROM `ingredient` WHERE `id_ingredient`={0}",
                Convert.ToInt32(tb_id_ingredient.Text));
            executeMyQuery(insert_query);
            data_reuse();
        }

        private bool el_is_valid(string gram_in_product)
        {
            bool flag = true;
            string regex = @"[0-9]{11}";
            if (!Regex.IsMatch(gram_in_product, regex))
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
