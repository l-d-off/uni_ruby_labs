# ------------------------------ ДАННЫЕ СО ВТОРОЙ ЛАБЫ ------------------------------
require 'yaml'

# ----------------------------------- DEPARTMENT -----------------------------------
class Department < Object
    attr_accessor :name
    attr_accessor :phone
    # attr_accessor :duties
    attr_reader :index_duty
    # attr_accessor :posts
    attr_reader :index_post

    def initialize name, phone, duties, posts
        @name = name
        @phone = phone
        @duties = duties.uniq
        @posts = posts
    end

    def init_yml file = File.read('department.yml')
        self.deserialize file
    end

    def to_s
        return "- Отдел: #{@name}\n" +
        "- Телефон: #{@phone}\n" +
        "- Обязанности: #{@duties}\n" +
        "- #{@posts.to_s}"
    end

    def get_data
        return
        "Отдел: #{@name}\n" +
        "Телефон: #{@phone}\n"
    end

    # duty
    def add_duty duty
        if !(@duties.include? duty)
            @duties.push duty
        end
    end

    def delete_duty
        if @index_duty >= 0 && @index_duty < @duties.size
            prev_index_duty = @index_duty
            prev_duty = @duties[@index_duty]
            @duties.delete_at @index_duty
            @index_duty = -1
            return "DUTY #{prev_duty} ON #{prev_index_duty} POSITION WAS DELETED"
        else
            return "DUTY IS NOT EXIST"
        end
    end

    def choose_duty index_duty
        if index_duty >= 0 && index_duty < @duties.size
            @index_duty = index_duty
            return "DUTY #{@duties[@index_duty]} ON #{@index_duty} POSITION WAS CHOSE"
        else
            return "DUTY IS NOT EXIST"
        end
    end

    def get_text_duty
        if @index_duty != -1
            return @duties[@index_duty]
        end
    end

    def change_text_duty duty
        prev_duty = @duties[@index_duty]
        @duties[@index_duty] = duty
        return "#{prev_duty} WAS CHANGED TO #{duty}"
    end

    # post
    def add_post post
        if !(@posts.include? post)
            @posts.push post
        end
    end

    def delete_post
        if @index_post >= 0 && @index_post < @posts.size
            prev_index_post = @index_post
            prev_post = @posts[@index_post]
            @posts.delete_at @index_post
            @index_post = -1
            return "POST #{prev_post} ON #{prev_index_post} POSITION WAS DELETED"
        else
            return "POST IS NOT EXIST"
        end
    end

    def choose_post index_post
        if index_post >= 0 && index_post < @posts.size
            @index_post = index_post
            return "POST #{@posts[@index_post]} ON #{@index_post} POSITION WAS CHOSE"
        else
            return "POST IS NOT EXIST"
        end
    end

    def get_post
        if @index_post != -1
            return @posts[@index_post]
        end
    end

    def change_post post
        prev_post = @posts[@index_post]
        @posts[@index_post] = post
        return "#{prev_post} WAS CHANGED TO #{post}"
    end

    # get vacants
    def get_vacants
        vacants = []
        @posts.each { |post|
            if (post.vacant)
                vacants.push post
            end
        }
        return vacants
    end

    def self.check_phone phone
        return (/\+[\d]{11}/.match phone) != nil
    end

    def serialize
        File.open('department.yml', 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.deserialize file = File.read('department.yml')
        data = YAML.load file
        posts = []
        data[:posts].each { |post|
            # динамически создаём объект класса (по названию)
            salary_class = post[:salary][:class]
            salary_object_data = []
            post[:salary].each {
                |key, value|
                if key != :class
                    salary_object_data.push value
                end
            }
            salary_object = Object.const_get(salary_class).new *salary_object_data
            posts.push Post.new post[:department], post[:name], salary_object, post[:vacant]
        }
        post_list = Post_list.new posts
        return self.new data[:name], data[:phone], data[:duties], post_list
    end

    def to_hash
        return {
            :name => @name,
            :phone => @phone,
            :duties => @duties,
            :posts => @posts.to_hash
        }
    end
end

# ----------------------------------- DEPARTMENT LIST -----------------------------------
class Department_list
    # attr_accessor :deps
    attr_reader :index_note

    def initialize deps
        @deps = deps
    end

    def to_s
        s = "> Отделы\n"
        @deps.each { |dep|
            s += dep.to_s
        }
        return s
    end

    def sort
        @deps.sort! { |dep1, dep2| dep1.name <=> dep2.name }
    end

    def sort_of_vacants
        @deps.sort! { |dep1, dep2| 
            dep1.posts.count_of_vacants <=> dep2.posts.count_of_vacants
        }
    end

    def add_note note
        if !(@deps.include? note)
            @deps.push note
        end
    end

    def delete_note
        if @index_note >= 0 && @index_note < @deps.size
            prev_index_note = @index_note
            prev_note = @deps[@index_note]
            @deps.delete_at @index_note
            @index_note = -1
            return "NOTE #{prev_note} ON #{prev_index_note} POSITION WAS DELETED"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def choose_note index_note
        if index_note >= 0 && index_note < @deps.size
            @index_note = index_note
            return "NOTE #{@deps[@index_note]} ON #{@index_note} POSITION WAS CHOSE"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def get_note
        if @index_note != -1
            return @deps[@index_note]
        end
    end

    def change_note note
        prev_note = @deps[@index_note]
        @deps[@index_note] = note
        return "#{prev_note} WAS CHANGED TO #{note}"
    end

    # А ЧТО СЕРИАЛИЗУЕМ?
    def serialize
        File.open('department_list.yml', 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    # И ЧТО ДЕСЕРИАЛИЗУЕМ?
    def self.deserialize file = File.read('department_list.yml')
        data = YAML.load file
        deps = []
        data.each { |field|
            posts = []
            field[:posts].each { |post|
                # динамически создаём объект класса (по названию)
                salary_class = post[:salary][:class]
                salary_object_data = []
                post[:salary].each {
                    |key, value|
                    if key != :class
                        salary_object_data.push value
                    end
                }
                salary_object = Object.const_get(salary_class).new *salary_object_data
                posts.push Post.new post[:department], post[:name], salary_object, post[:vacant]
            }
            post_list = Post_list.new posts
            deps.push Department.new field[:name], field[:phone], field[:duties], post_list
        }
        return self.new deps
    end

    def init_deps_name_has string
        return Department_list.new @deps.each.map { |dep|
            if dep.name[string] != nil
                dep
            end
        }
    end

    def to_hash
        hash_list = []
        @deps.each { |dep|
            hash_list.push dep.to_hash
        }
        return hash_list
    end
end

# ---------------------------------------- POST ----------------------------------------
class Post # должность
    attr_accessor :department # отдел
    attr_accessor :name # название
    attr_accessor :salary # оклад
    attr_accessor :vacant # вакантна или нет
    # attr_accessor :jobs # рабочие места

    def initialize department, name, salary, vacant
        @department = department
        @name = name
        @salary = salary
        @vacant = vacant
    end

    def to_s
        return "- - Должность: #{@name}\n" +
        "- - Оклад: #{@salary}\n" +
        "- - Вакантна: #{@vacant ? "да" : "нет"}\n" +
        "<-------------------->\n"
    end

    def serialize
        File.open('post.yml', 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.deserialize file = File.read('post.yml')
        data = YAML.load file
        # динамически создаём объект класса (по названию)
        salary_class = data[:salary][:class]
        salary_object_data = []
        data[:salary].each {
            |key, value|
            if key != :class
                salary_object_data.push value
            end
        }
        salary_object = Object.const_get(salary_class).new *salary_object_data
        return self.new data[:department], data[:name], salary_object, data[:vacant]
    end

    def take_the_job employee, percent_salary
        return Job.new self, employee, 2000, nil, percent_salary
    end

    def join_the_job job
        @job_list.push job
    end

    def quit_the_job job
        @job_list.delete job
    end

    def to_hash
        return {
            :department => @department,
            :name => @name,
            :salary => @salary.to_hash,
            :vacant => @vacant
        }
    end
end

# ---------------------------------------- POST LIST ----------------------------------------
class Post_list
    # attr_accessor :posts
    attr_reader :index_note

    def initialize posts
        @posts = posts
    end

    def to_s
        s = "> Должности\n"
        @posts.each { |post|
            s += post.to_s
        }
        return s
    end

    def sort
        posts.sort! { |post1, post2| post1.name <=> post2.name }
    end

    def add_note note
        if !(@posts.include? note)
            @posts.push note
        end
    end

    def delete_note
        if @index_note >= 0 && @index_note < @posts.size
            prev_index_note = @index_note
            prev_note = @posts[@index_note]
            @posts.delete_at @index_note
            @index_note = -1
            return "NOTE #{prev_note} ON #{prev_index_note} POSITION WAS DELETED"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def choose_note index_note
        if index_note >= 0 && index_note < @posts.size
            @index_note = index_note
            return "NOTE #{@posts[@index_note]} ON #{@index_note} POSITION WAS CHOSE"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def get_note
        if @index_note != -1
            return @posts[@index_note]
        end
    end

    def change_note note
        prev_note = @posts[@index_note]
        @posts[@index_note] = note
        return "#{prev_note} WAS CHANGED TO #{note}"
    end

    # А ЧТО СЕРИАЛИЗУЕМ?
    def serialize file = 'post_list.yml'
        File.open(file, 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    # И ЧТО ДЕСЕРИАЛИЗУЕМ?
    def self.deserialize file = File.read('post_list.yml')
        data = YAML.load file
        posts = []
        data.each { |field|
            # динамически создаём объект класса (по названию)
            salary_class = field[:salary][:class]
            salary_object_data = []
            field[:salary].each {
                |key, value|
                if key != :class
                    salary_object_data.push value
                end
            }
            salary_object = Object.const_get(salary_class).new *salary_object_data
            posts.push Post.new field[:department], field[:name], salary_object, field[:vacant]
        }
        return self.new posts
    end

    def count_of_vacants
        count = 0
        @posts.each { |post|
            if post.vacant
                count += 1
            end
        }
        return count
    end

    def init_posts_in department
        return Post_list.new @posts.each.map { |post|
            if post.department == department
                post
            end
        }
    end

    def init_vacant_posts_in department
        return Post_list.new @posts.each.map { |post|
            if post.department == department && post.vacant
                post
            end
        }
    end

    def init_posts_name_has string
        return Post_list.new @posts.each.map { |post|
            if post.name[string] != nil
                post
            end
        }
    end

    def to_hash
        hash_list = []
        @posts.each { |post|
            hash_list.push post.to_hash 
        }
        return hash_list
    end
end

# -------------------------------------- ТРЕТЬЯ ЛАБА --------------------------------------
class Salary
    def get_salary
    end

    def to_s
    end

    def to_hash
    end
end

# ---------------------------------------- ОБЫЧНЫЕ ----------------------------------------

class Fix_sal < Salary
    # attr_accessor :salary

    def initialize salary
        @salary = salary
    end

    def get_salary
        return @salary
    end

    def to_s
        return "#{get_salary}"
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary
        }
    end
end

class Rub_sal < Fix_sal
    attr_accessor :add_rub

    def initialize salary, add_rub
        super salary
        @add_rub = add_rub
    end

    def get_salary
        return super + @add_rub
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub
        }
    end
end

class Percent_sal < Fix_sal
    attr_accessor :add_percent

    def initialize salary, add_percent
        super salary
        @add_percent = add_percent
    end

    def get_salary
        return [super, super * (100 + @add_percent) / 100].sample
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_percent => @add_percent
        }
    end
end

class Rub_percent_sal < Percent_sal
    attr_accessor :add_rub

    def initialize salary, add_rub, add_percent
        super salary, add_percent
        @add_rub = add_rub
    end

    def get_salary
        return super + @add_rub
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :add_percent => @add_percent
        }
    end
end

# ---------------------------------------- ШТРАФЫ ----------------------------------------
class Fine_sal < Fix_sal
    attr_accessor :fine

    def initialize salary, fine
        super salary
        @fine = fine
    end

    def get_salary
        return super - @fine
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :fine => @fine
        }
    end
end

class Fine_rub_sal < Rub_sal
    attr_accessor :fine

    def initialize salary, add_rub, fine
        super salary, add_rub
        @fine = fine
    end

    def get_salary
        return super - @fine
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :fine => @fine
        }
    end
end

class Fine_percent_sal < Percent_sal
    attr_accessor :fine

    def initialize salary, add_percent, fine
        super salary, add_percent
        @fine = fine
    end

    def get_salary
        return super - @fine
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_percent => @add_percent,
            :fine => @fine
        }
    end
end

class Fine_rub_percent_sal < Rub_percent_sal
    attr_accessor :fine

    def initialize salary, add_rub, add_percent, fine
        super salary, add_rub, add_percent
        @fine = fine
    end

    def get_salary
        return super - @fine
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :add_percent => @add_percent,
            :fine => @fine
        }
    end
end

# ----------------------------------- ПРЕМИЯ ОБЫЧНЫЕ -----------------------------------
class Premium_sal < Fix_sal
    attr_accessor :premium

    def initialize salary, premium
        super salary
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :premium => @premium
        }
    end
end

class Premium_rub_sal < Rub_sal
    attr_accessor :premium

    def initialize salary, add_rub, premium
        super salary, add_rub
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :premium => @premium
        }
    end
end

class Premium_percent_sal < Percent_sal
    attr_accessor :premium

    def initialize salary, add_percent, premium
        super salary, add_percent
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_percent => @add_percent,
            :premium => @premium
        }
    end
end

class Premium_rub_percent_sal < Rub_percent_sal
    attr_accessor :premium

    def initialize salary, add_rub, add_percent, premium
        super salary, add_rub, add_percent
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :add_percent => @add_percent,
            :premium => @premium
        }
    end
end

# ----------------------------------- ПРЕМИЯ ШТРАФЫ -----------------------------------
class Premium_fine_sal < Fine_sal
    attr_accessor :premium

    def initialize salary, fine, premium
        super salary, fine
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :fine => @fine,
            :premium => @premium
        }
    end
end

class Premium_fine_rub_sal < Fine_rub_sal
    attr_accessor :premium

    def initialize salary, add_rub, fine, premium
        super salary, add_rub, fine
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :fine => @fine,
            :premium => @premium
        }
    end
end

class Premium_fine_percent_sal < Fine_percent_sal
    attr_accessor :premium

    def initialize salary, add_percent, fine, premium
        super salary, add_percent, fine
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_percent => @add_percent,
            :fine => @fine,
            :premium => @premium
        }
    end
end

class Premium_fine_rub_percent_sal < Fine_rub_percent_sal
    attr_accessor :premium

    def initialize salary, add_rub, add_percent, fine, premium
        super salary, add_rub, add_percent, fine
        @premium = premium
    end

    def get_salary
        return super + @premium
    end

    def to_hash
        return {
            :class => self.class.name,
            :salary => @salary,
            :add_rub => @add_rub,
            :add_percent => @add_percent,
            :fine => @fine,
            :premium => @premium
        }
    end
end

# ----------------------------------- КЛАСС EMPLOYEE -----------------------------------
class Employee
    attr_accessor :fio
    attr_accessor :birth_year
    attr_accessor :passport
    attr_accessor :phone
    attr_accessor :address
    attr_accessor :email

    def initialize fio, birth_year, passport, phone, address, email
        @fio = fio
        @birth_year = birth_year
        @passport = passport
        @phone = phone
        @address = address
        @email = email
    end

    def to_hash
        return {
            :fio => @fio,
            :birth_year => birth_year,
            :passport => @passport,
            :phone => @phone,
            :address => @address,
            :email => @email
        }
    end
end

class Skilled_employee < Employee
    attr_accessor :experience
    attr_accessor :description

    def initialize fio, birth_year, passport, phone, address, email, experience, description
        super fio, birth_year, passport, phone, address, email
        @experience = experience
        @description = description
    end

    def to_hash
        return {
            :fio => @fio,
            :birth_year => birth_year,
            :passport => @passport,
            :phone => @phone,
            :address => @address,
            :email => @email,
            :experience => @experience,
            :description => @description
        }
    end
end

# ----------------------------------- КОЛЛЕКЦИИ ДАННЫХ -----------------------------------

class Employee_list
    # attr_accessor :employees
    attr_reader :index_note

    def initialize employees
        @employees = employees
    end

    def to_s
        s = "> Сотрудники\n"
        @employees.each { |employee|
            s += employees.to_s
        }
        return s
    end

    def sort
        employees.sort! { |employee1, employee2| employee1.name <=> employee2.name }
    end

    def add_note note
        if !(@employees.include? note)
            @employees.push note
        end
    end

    def delete_note
        if @index_note >= 0 && @index_note < @employees.size
            prev_index_note = @index_note
            prev_note = @employees[@index_note]
            @employees.delete_at @index_note
            @index_note = -1
            return "NOTE #{prev_note} ON #{prev_index_note} POSITION WAS DELETED"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def choose_note index_note
        if index_note >= 0 && index_note < @employees.size
            @index_note = index_note
            return "NOTE #{@employees[@index_note]} ON #{@index_note} POSITION WAS CHOSE"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def get_note
        if @index_note != -1
            return @employees[@index_note]
        end
    end

    def change_note note
        prev_note = @employees[@index_note]
        @employees[@index_note] = note
        return "#{prev_note} WAS CHANGED TO #{note}"
    end

    # А ЧТО СЕРИАЛИЗУЕМ?
    def serialize file = 'employee_list.yml'
        File.open(file, 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    # И ЧТО ДЕСЕРИАЛИЗУЕМ?
    def self.deserialize file = File.read('employee_list.yml')
        data = YAML.load file
        employees = []
        data.each { |field|
            employees.push Employee.new field[:fio], field[:birthdate], field[:passport], field[:phone], field[:address], field[:email]
        }
        return self.new employees
    end

    def init_employees_name_has string
        return Employee_list.new @employees.each.map { |employee|
            if employee.fio[string] != nil
                employee
            end
        }
    end

    def init_employees_people_whose_age_is age
        return Employee_list.new @employees.each.map { |employee|
            if Time.new.year - employee.birth_year == age
                employee
            end
        }
    end

    def init_employees_people_whose_age_younger_than age
        return Employee_list.new @employees.each.map { |employee|
            if Time.new.year - employee.birth_year < age
                employee
            end
        }
    end

    def init_employees_people_whose_age_older_than age
        return Employee_list.new @employees.each.map { |employee|
            if Time.new.year - employee.birth_year > age
                employee
            end
        }
    end

    def init_employees_people_whose_age_is_in_the_range first_age, last_age
        return Employee_list.new @employees.each.map { |employee|
            if Time.new.year - employee.birth_year >= first_age &&
                Time.new.year - employee.birth_year <= last_age
                employee
            end
        }
    end

    def to_hash
        hash_list = []
        @employees.each { |employee|
            hash_list.push employee.to_hash 
        }
        return hash_list
    end
end

# -------------------------------------- КЛАСС JOB --------------------------------------
class Job
    attr_accessor :post
    attr_accessor :employee
    attr_accessor :start_job_year
    attr_accessor :end_job_year
    attr_accessor :percent_salary

    def initialize post, employee, start_job_year, end_job_year, percent_salary
        @post = post
        @employee = employee
        @start_job_year = start_job_year
        @end_job_year = end_job_year
        @percent_salary = percent_salary
    end
end

class Job_list
    # attr_accessor :jobs
    attr_reader :index_note

    def initialize jobs
        @jobs = jobs
    end

    def to_s
        s = "> Рабочие места\n"
        @jobs.each { |job|
            s += jobs.to_s
        }
        return s
    end

    def sort
        @jobs.sort! { |job1, job2| job1.name <=> job2.name }
    end

    def add_note note
        if !(@jobs.include? note)
            @jobs.push note
        end
    end

    def delete_note
        if @index_note >= 0 && @index_note < @jobs.size
            prev_index_note = @index_note
            prev_note = @jobs[@index_note]
            @jobs.delete_at @index_note
            @index_note = -1
            return "NOTE #{prev_note} ON #{prev_index_note} POSITION WAS DELETED"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def choose_note index_note
        if index_note >= 0 && index_note < @jobs.size
            @index_note = index_note
            return "NOTE #{@jobs[@index_note]} ON #{@index_note} POSITION WAS CHOSE"
        else
            return "NOTE IS NOT EXIST"
        end
    end

    def get_note
        if @index_note != -1
            return @jobs[@index_note]
        end
    end

    def change_note note
        prev_note = @jobs[@index_note]
        @jobs[@index_note] = note
        return "#{prev_note} WAS CHANGED TO #{note}"
    end

    # А ЧТО СЕРИАЛИЗУЕМ?
    def serialize file = 'job_list.yml'
        File.open(file, 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    # И ЧТО ДЕСЕРИАЛИЗУЕМ?
    def self.deserialize file = File.read('job_list.yml')
        data = YAML.load file
        jobs = []
        data.each { |field|
            jobs.push Job.new field[:post], field[:employee], field[:start_job_year], field[:end_job_year], field[:percent_salary]
        }
        return self.new jobs
    end

    def get_jobs_post_is post
        return @jobs.each.map { |job|
            if job.post == post
                job
            end
        }
    end

    def get_jobs_employee_is employee
        return @jobs.each.map { |job|
            if job.employee == employee
                job
            end
        }
    end

    def get_posts_employee_is
        return @jobs
    end

    def to_hash
        hash_list = []
        @jobs.each { |job|
            hash_list.push job.to_hash 
        }
        return hash_list
    end
end

/
Как можно сократить код?
Его можно сократить в методах десериализации следующим образом:
1. Достаём hash-объект из yml
2. Вызываем Class.serialize (объект соответствующего типа помещается в соответствующий файл)
3. Вызываем Class.deserialize от того же класса (таким образом мы получим объект из метода)
/

salary1 = Fix_sal.new 1750
salary2 = Percent_sal.new 100, 10
salary3 = Premium_fine_percent_sal.new 2750, 15, 150, 1000
salary4 = Fine_rub_sal.new 20, 10, 5

post1 = Post.new "Google", "директор", salary1, false
post2 = Post.new "Google", "сотрудник", salary2, true
post3 = Post.new "Yandex", "директор", salary3, false
post4 = Post.new "Yandex", "сотрудник", salary4, false
posts1 = Post_list.new [post1, post2]
posts2 = Post_list.new [post3, post4]

dep1 = Department.new "Google", "+79997776655", ["1", "2"], posts1
dep2 = Department.new "Yandex", "+75553332211", ["3"], posts2
deps = Department_list.new [dep1, dep2]

puts "\nДАННЫЕ КЛАССА Department_list\n"
deps.serialize
gg = Department_list.deserialize
puts gg

puts "\nДАННЫЕ КЛАССА Post\n"
post1.serialize
puts Post.deserialize

puts "\nДАННЫЕ КЛАССА Post_list\n"
posts1.serialize
puts Post_list.deserialize

puts "\nДАННЫЕ КЛАССА Department\n"
dep1.serialize
puts Department.deserialize

puts "\nДОЛЖНОСТИ ОТДЕЛА Google\n"
puts posts1.init_posts_in "Google"

puts "\nВАКАНТНЫЕ ДОЛЖНОСТИ ОТДЕЛА Google\n"
puts posts1.init_vacant_posts_in "Google"

puts "\nДОЛЖНОСТИ, В НАЗВАНИИ КОТОРЫХ СОДЕРЖИТСЯ ректор\n"
puts posts1.init_posts_name_has "ректор"