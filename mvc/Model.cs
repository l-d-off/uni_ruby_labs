using System;
using System.Collections.Generic;

namespace projectsamozachet
{
   public class Facade
    {
        public Product_list product_list;
        public Ingredient_list ingredient_list;
        public Dish_list dish_list;

        public Facade()
        {
            this.product_list = Product_list.get_instanse();
            this.ingredient_list = Ingredient_list.get_instanse();
            this.dish_list = Dish_list.get_instanse();
        }

        /// CREATE PRODUCT LIST
        public void create_product_list(Object[] obj)
        {
            product_list.add_el(new Product(
                Convert.ToInt32(obj[0]),
                obj[1].ToString(),
                Convert.ToInt32(obj[2])
                ));
        }

        /// CREATE INGREDIENT LIST
        public void create_ingredient_list(Object[] obj)
        {
            ingredient_list.add_el(new Ingredient(
                Convert.ToInt32(obj[0]),
                Convert.ToInt32(obj[1]),
                Convert.ToInt32(obj[2]),
                Convert.ToInt32(obj[3])
                ));
        }

        /// CREATE DISH LIST
        public void create_dish_list(Object[] obj)
        {
            dish_list.add_el(new Dish(
                Convert.ToInt32(obj[0]),
                obj[1].ToString(),
                obj[2].ToString(),
                Convert.ToInt32(obj[3]),
                Convert.ToInt32(obj[4])
                ));
        }

        /// UPDATE PRODUCT LIST
        public void update_product_list(Object[] obj)
        {
            product_list.update_el(new Product(
                Convert.ToInt32(obj[0]),
                obj[1].ToString(),
                Convert.ToInt32(obj[2])
                ));
        }

        /// UPDATE INGREDIENT LIST
        public void update_ingredient_list(Object[] obj)
        {
            ingredient_list.update_el(new Ingredient(
                Convert.ToInt32(obj[0]),
                Convert.ToInt32(obj[1]),
                Convert.ToInt32(obj[2]),
                Convert.ToInt32(obj[3])
                ));
        }

        /// UPDATE DISH LIST
        public void update_dish_list(Object[] obj)
        {
            dish_list.update_el(new Dish(
                Convert.ToInt32(obj[0]),
                obj[1].ToString(),
                obj[2].ToString(),
                Convert.ToInt32(obj[3]),
                Convert.ToInt32(obj[4])
                ));
        }

        /** -------------------------------------- PRODUCT -------------------------------------- **/
        public class Product : Id
        {
            public int id_product { get; set; }
            public string name_product { get; set; }
            public int price_1kg_rub { get; set; }

            public Product(int id_product, string name_product, int price_1kg_rub)
            {
                this.id_product = id_product;
                this.name_product = name_product;
                this.price_1kg_rub = price_1kg_rub;
            }

            public int id()
            {
                return id_product;
            }

            public List<String> get_list_product()
            {
                List<String> list_product = new List<String>();
                list_product.Add(id_product.ToString());
                list_product.Add(name_product);
                list_product.Add(price_1kg_rub.ToString());
                return list_product;
            }
        }

        /** --------------------------------------- DISH --------------------------------------- **/
        public class Dish : Id
        {
            public int id_dish { get; set; }
            public string name_dish { get; set; }
            public string type_dish { get; set; }
            public int weight_gram { get; set; }
            public int price_rub { get; set; }

            public Dish(int id_dish, string name_dish, string type_dish, int weight_gram, int price_rub)
            {
                this.id_dish = id_dish;
                this.name_dish = name_dish;
                this.type_dish = type_dish;
                this.weight_gram = weight_gram;
                this.price_rub = price_rub;
            }

            public int id()
            {
                return id_dish;
            }

            public List<String> get_list_dish()
            {
                List<String> list_dish = new List<String>();
                list_dish.Add(id_dish.ToString());
                list_dish.Add(name_dish);
                list_dish.Add(type_dish);
                list_dish.Add(weight_gram.ToString());
                list_dish.Add(price_rub.ToString());
                return list_dish;
            }
        }

        /** ------------------------------------ INGREDIENT ------------------------------------ **/
        public class Ingredient : Id
        {
            public int id_ingredient { get; set; }
            public int id_dish { get; set; }
            public int id_product { get; set; }
            public int gram_in_product { get; set; }
     
            public Ingredient(int id_ingredient, int id_dish, int id_product, int gram_in_product)
            {
                this.id_ingredient = id_ingredient;
                this.id_dish = id_dish;
                this.id_product = id_product;
                this.gram_in_product = gram_in_product;
            }

            public int id()
            {
                return id_ingredient;
            }

            public List<String> get_list_ingredient()
            {
                List<String> list_ingredient = new List<String>();
                list_ingredient.Add(id_ingredient.ToString());
                list_ingredient.Add(id_dish.ToString());
                list_ingredient.Add(id_product.ToString());
                list_ingredient.Add(gram_in_product.ToString());
                return list_ingredient;
            }
        }

        interface Id
        {
            int id();
        }

        interface IList<T>
        {
            void add_el(T obj);
            void delete_el(int id);
            void update_el(T obj);
            Object select_el(T obj);
        }

        /** ----------------------------------- PRODUCT LIST ----------------------------------- **/
        public class Product_list : IList<Product>
        {
            private List<Product> product_list;
            private static Product_list one;

            private Product_list()
            {
                product_list = new List<Product>();
            }

            public static Product_list get_instanse()
            {
                if (one == null)
                    one = new Product_list();
                return one;
            }

            public void add_el(Product client)
            {
                this.product_list.Add(client);
            }

            public void delete_el(int id)
            {
                this.product_list.RemoveAll(client => client.id() == id);
            }

            public void update_el(Product id)
            {
                Product old_client = this.product_list.Find(client => client.id() == id.id());
                old_client.id_product = id.id_product;
                old_client.name_product = id.name_product;
                old_client.price_1kg_rub = id.price_1kg_rub;
            }

            public Object select_el(Product obj)
            {
                return 1;
            }

            public List<List<string>> get_list_client()
            {
                List<List<string>> list_client = new List<List<string>>();
                foreach (Product product in this.product_list)
                    list_client.Add(product.get_list_product());
                return list_client;
            }

            public List<string> get_list_id()
            {
                List<string> list_id = new List<string>();
                foreach(Product product in product_list)
                    list_id.Add(product.id().ToString());
                return list_id;
            }
        }

        /** ---------------------------------- INGREDIENT LIST ---------------------------------- **/
        public class Ingredient_list : IList<Ingredient>
        {
            private List<Ingredient> ingredient_list;
            private static Ingredient_list one;

            private Ingredient_list()
            {
                ingredient_list = new List<Ingredient>();
            }

            public static Ingredient_list get_instanse()
            {
                if (one == null)
                    one = new Ingredient_list();
                return one;
            }

            public void add_el(Ingredient client)
            {
                this.ingredient_list.Add(client);
            }

            public void delete_el(int id)
            {
                this.ingredient_list.RemoveAll(client => client.id() == id);
            }

            public void update_el(Ingredient id)
            {
                Ingredient old_client = this.ingredient_list.Find(client => client.id() == id.id());
                old_client.id_ingredient = id.id_ingredient;
                old_client.id_dish = id.id_dish;
                old_client.id_product = id.id_product;
                old_client.gram_in_product = id.gram_in_product;
            }

            public Object select_el(Ingredient obj)
            {
                return 1;
            }

            public List<List<string>> get_list_client()
            {
                List<List<string>> list_client = new List<List<string>>();
                foreach (Ingredient ingredient in this.ingredient_list)
                    list_client.Add(ingredient.get_list_ingredient());
                return list_client;
            }

            public List<string> get_list_id()
            {
                List<string> list_id = new List<string>();
                foreach (Ingredient ingredient in ingredient_list)
                    list_id.Add(ingredient.id().ToString());
                return list_id;
            }
        }

        /** ------------------------------------- DISH LIST ------------------------------------- **/
        public class Dish_list : IList<Dish>
        {
            private List<Dish> dish_list;
            private static Dish_list one;

            private Dish_list()
            {
                dish_list = new List<Dish>();
            }

            public static Dish_list get_instanse()
            {
                if (one == null)
                    one = new Dish_list();
                return one;
            }

            public void add_el(Dish client)
            {
                this.dish_list.Add(client);
            }

            public void delete_el(int id)
            {
                this.dish_list.RemoveAll(client => client.id() == id);
            }

            public void update_el(Dish id)
            {
                Dish old_client = this.dish_list.Find(client => client.id() == id.id());
                old_client.id_dish = id.id_dish;
                old_client.name_dish = id.name_dish;
                old_client.type_dish = id.type_dish;
                old_client.weight_gram = id.weight_gram;
                old_client.price_rub = id.price_rub;
            }

            public Object select_el(Dish obj)
            {
                return 1;
            }

            public List<List<string>> get_list_client()
            {
                List<List<string>> list_client = new List<List<string>>();
                foreach (Dish dish in this.dish_list)
                    list_client.Add(dish.get_list_dish());
                return list_client;
            }

            public List<string> get_list_id()
            {
                List<string> list_id = new List<string>();
                foreach (Dish dish in dish_list)
                    list_id.Add(dish.id().ToString());
                return list_id;
            }
        }
   }
}
