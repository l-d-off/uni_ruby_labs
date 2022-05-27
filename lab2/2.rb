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

    def to_hash
        hash_list = []
        @posts.each { |post|
            hash_list.push post.to_hash 
        }
        return hash_list
    end
end
