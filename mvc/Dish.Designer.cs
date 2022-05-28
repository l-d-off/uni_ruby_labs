
namespace projectsamozachet
{
    partial class Dish
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dgv_dish = new System.Windows.Forms.DataGridView();
            this.tb_id_dish = new System.Windows.Forms.TextBox();
            this.tb_name_dish = new System.Windows.Forms.TextBox();
            this.tb_type_dish = new System.Windows.Forms.TextBox();
            this.btn_update = new System.Windows.Forms.Button();
            this.btn_delete = new System.Windows.Forms.Button();
            this.btn_insert = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.execute_info = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label5 = new System.Windows.Forms.Label();
            this.tb_price_rub = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.tb_weight_gram = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_dish)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // dgv_dish
            // 
            this.dgv_dish.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_dish.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_dish.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_dish.Location = new System.Drawing.Point(3, 3);
            this.dgv_dish.Name = "dgv_dish";
            this.dgv_dish.RowHeadersWidth = 51;
            this.dgv_dish.RowTemplate.Height = 24;
            this.dgv_dish.Size = new System.Drawing.Size(753, 286);
            this.dgv_dish.TabIndex = 0;
            // 
            // tb_id_dish
            // 
            this.tb_id_dish.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_id_dish.Location = new System.Drawing.Point(188, 295);
            this.tb_id_dish.Name = "tb_id_dish";
            this.tb_id_dish.Size = new System.Drawing.Size(568, 35);
            this.tb_id_dish.TabIndex = 3;
            // 
            // tb_name_dish
            // 
            this.tb_name_dish.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_name_dish.Location = new System.Drawing.Point(188, 336);
            this.tb_name_dish.Name = "tb_name_dish";
            this.tb_name_dish.Size = new System.Drawing.Size(568, 35);
            this.tb_name_dish.TabIndex = 4;
            // 
            // tb_type_dish
            // 
            this.tb_type_dish.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_type_dish.Location = new System.Drawing.Point(188, 377);
            this.tb_type_dish.Name = "tb_type_dish";
            this.tb_type_dish.Size = new System.Drawing.Size(568, 35);
            this.tb_type_dish.TabIndex = 5;
            // 
            // btn_update
            // 
            this.btn_update.BackColor = System.Drawing.Color.White;
            this.btn_update.Cursor = System.Windows.Forms.Cursors.Cross;
            this.btn_update.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn_update.Location = new System.Drawing.Point(779, 309);
            this.btn_update.Name = "btn_update";
            this.btn_update.Size = new System.Drawing.Size(165, 164);
            this.btn_update.TabIndex = 16;
            this.btn_update.Text = "изменить";
            this.btn_update.UseVisualStyleBackColor = false;
            this.btn_update.Click += new System.EventHandler(this.button_update_Click);
            // 
            // btn_delete
            // 
            this.btn_delete.BackColor = System.Drawing.Color.White;
            this.btn_delete.Cursor = System.Windows.Forms.Cursors.Cross;
            this.btn_delete.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn_delete.Location = new System.Drawing.Point(817, 145);
            this.btn_delete.Name = "btn_delete";
            this.btn_delete.Size = new System.Drawing.Size(209, 158);
            this.btn_delete.TabIndex = 15;
            this.btn_delete.Text = "удалить";
            this.btn_delete.UseVisualStyleBackColor = false;
            this.btn_delete.Click += new System.EventHandler(this.button_delete_Click);
            // 
            // btn_insert
            // 
            this.btn_insert.BackColor = System.Drawing.Color.White;
            this.btn_insert.Cursor = System.Windows.Forms.Cursors.Cross;
            this.btn_insert.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btn_insert.Location = new System.Drawing.Point(780, 14);
            this.btn_insert.Name = "btn_insert";
            this.btn_insert.Size = new System.Drawing.Size(201, 125);
            this.btn_insert.TabIndex = 14;
            this.btn_insert.Text = "добавить";
            this.btn_insert.UseVisualStyleBackColor = false;
            this.btn_insert.Click += new System.EventHandler(this.button_insert_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(8, 380);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(55, 29);
            this.label3.TabIndex = 12;
            this.label3.Text = "тип";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(8, 339);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(124, 29);
            this.label2.TabIndex = 11;
            this.label2.Text = "название";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(8, 298);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(33, 29);
            this.label1.TabIndex = 10;
            this.label1.Text = "id";
            // 
            // execute_info
            // 
            this.execute_info.AutoSize = true;
            this.execute_info.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.execute_info.Location = new System.Drawing.Point(822, 476);
            this.execute_info.Name = "execute_info";
            this.execute_info.Size = new System.Drawing.Size(168, 29);
            this.execute_info.TabIndex = 17;
            this.execute_info.Text = "запросов нет";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.tb_price_rub);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.tb_weight_gram);
            this.panel1.Controls.Add(this.dgv_dish);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.tb_id_dish);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.tb_name_dish);
            this.panel1.Controls.Add(this.tb_type_dish);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(13, 14);
            this.panel1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(759, 498);
            this.panel1.TabIndex = 18;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.Location = new System.Drawing.Point(8, 462);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(174, 29);
            this.label5.TabIndex = 16;
            this.label5.Text = "цена в рублях";
            // 
            // tb_price_rub
            // 
            this.tb_price_rub.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_price_rub.Location = new System.Drawing.Point(188, 459);
            this.tb_price_rub.Name = "tb_price_rub";
            this.tb_price_rub.Size = new System.Drawing.Size(568, 35);
            this.tb_price_rub.TabIndex = 15;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(8, 421);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(175, 29);
            this.label4.TabIndex = 14;
            this.label4.Text = "вес в граммах";
            // 
            // tb_weight_gram
            // 
            this.tb_weight_gram.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_weight_gram.Location = new System.Drawing.Point(188, 418);
            this.tb_weight_gram.Name = "tb_weight_gram";
            this.tb_weight_gram.Size = new System.Drawing.Size(568, 35);
            this.tb_weight_gram.TabIndex = 13;
            // 
            // Dish
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1039, 526);
            this.Controls.Add(this.btn_update);
            this.Controls.Add(this.btn_delete);
            this.Controls.Add(this.btn_insert);
            this.Controls.Add(this.execute_info);
            this.Controls.Add(this.panel1);
            this.Name = "Dish";
            this.Text = "Блюдо";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Dish_FormClosed);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_dish)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgv_dish;
        private System.Windows.Forms.TextBox tb_id_dish;
        private System.Windows.Forms.TextBox tb_name_dish;
        private System.Windows.Forms.TextBox tb_type_dish;
        private System.Windows.Forms.Button btn_update;
        private System.Windows.Forms.Button btn_delete;
        private System.Windows.Forms.Button btn_insert;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label execute_info;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tb_price_rub;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tb_weight_gram;
    }
}