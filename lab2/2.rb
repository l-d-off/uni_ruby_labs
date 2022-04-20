require 'yaml'

class Department < Object
    attr_accessor :name
    attr_accessor :phone
    attr_accessor :duties
    attr_reader :duty
    attr_reader :index_duty
    attr_accessor :posts
    attr_reader :post
    attr_reader :index_post

    def initialize name, phone, duties, posts
        @name = name
        @phone = phone
        @duties = duties.uniq
        @posts = posts
    end

    def init_yml file = File.read('2.yml')
        self.deserialize file
    end

    def init_txt file = File.read('2.txt')

    end

    def to_s
        #"#{@name}, #{@phone}, #{@duties}, #{@posts}"
        "Name: #{@name}\n" +
        "Phone: #{@phone}\n" +
        "Duties: #{@duties}\n" +
        "@ Posts @\n" +
        "#{@posts.to_s}"
    end

    def get_data
        "Name: #{@name}\n" +
        "Phone: #{@phone}"
    end

    # duty
    def add_duty duty
        if !(@duties.include? duty)
            @duties.push duty
        end
    end

    def delete_duty duty
        if @duty == duty
            @duty = ""
            @index_duty = -1
        end
        @duties.delete duty
    end

    def choose_duty duty
        @index_duty = -1
        @duty = ""
        @duties.each_with_index { |el, i| if el == duty then @index_duty = i end }
        if @index_duty == -1
            "DUTY IS NOT EXIST"
        else
            @duty = duty
            "DUTY #{@duty} ON #{@index_duty} POSITION WAS CHOSE"
        end
    end

    def get_text_duty
        if @index_duty != -1
            @duty
        end
    end

    def change_text_duty duty
        prev = @duties[@index_duty]
        @duties[@index_duty] = duty
        @duty = duty
        "#{prev} WAS CHANGED TO #{@duty}"
    end

    # post
    def add_post post
        if !(@posts.include? post)
            @posts.push post
        end
    end

    def delete_post post
        if @post == post
            @post = ""
            @index_post = -1
        end
        @posts.delete post
    end

    def choose_post post
        @index_post = -1
        @post = nil
        @posts.each_with_index { |el, i| if el == post then @index_post = i end }
        if @index_post == -1
            "POST IS NOT EXIST"
        else
            @post = post
            "POST #{@post} ON #{@index_post} POSITION WAS CHOSE"
        end
    end

    def get_post
        if @index_post != -1
            @post
        end
    end

    def change_post post
        prev = @posts[@index_post]
        @posts[@index_post] = post
        @post = post
        "#{prev} WAS CHANGED TO #{@post}"
    end

    # get vacants
    def get_vacants
        vacants = []
        @posts.each { |post|
            if (post.vacant)
                vacants.push post
            end
        }
        vacants
    end

    def self.check_phone phone
        (/\+[\d]{11}/.match phone) != nil
    end

    def to_hash
        {
            :name => @name,
            :phone => @phone,
            :duties => @duties,
            :posts => @posts.to_hash
        }
    end

    def serialize
        File.open('2.yml', 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.deserialize file = File.read('2.yml')
        set = YAML.load file
        self.new set[:name], set[:phone], *set[:duties]
    end

    def self.read_from_txt path = 'read2.txt'
        file = File.read(path)
        #file = File.new(path, "r:UTF-8")
        #lines = file.readlines
        #lines
        splits = file.split("---\n")[1..]
        splits_inside = []
        splits.each { |el|
            splits_inside.push el.split "\n"
        }
        deps = []
        splits_inside.each { |el|
            name = el[0][6..]
            phone = el[1][7..]
            duties = []
            el[3..el.length - 2].each { |duty|
                duties.push duty[2..]
            }
            deps.push self.new name, phone, *duties
        }
        deps
    end

    def self.write_to_txt *deps
        file = File.new("write2.txt", "a:UTF-8")
        deps.each_with_index { |dep, i|
            file.print("---\r")
            file.print("name: #{dep.name}\r")
            file.print("phone: #{dep.phone}\r")
            file.print("duties:\r")
            dep.duties.each { |duty|
                file.print("- #{duty}\r")
            }
            if (i == deps.length - 1)
                file.print "- #"
            else
                file.print "- #\r"
            end
        }
        file.close
    end
end

#dep1 = Department.new "Google", "+79997776655", "1", "2"
#dep2 = Department.new "Yandex", "+75553332211", "3"
# puts dep1.to_s
#puts Department.check_phone("+79997776655") ? "правильно" : "неправильно"
#phone = gets.chomp
#dep3 = nil
#if Department.check_phone(phone)
#    dep3 = Department.new "Матрёшка", phone, "2", "3", "поставить на место"
#end
#puts dep3 != nil ? dep3 : "Объект не валиден"

# 3
class Department_list
    attr_accessor :deps
    attr_reader :note
    attr_reader :index_note

    def initialize *deps
        @deps = deps
    end

    def to_s
        @deps
    end

    def sort
        deps.sort! { |dep1, dep2| dep1.name <=> dep2.name }
    end

    def sort_of_vacants
        deps.sort! { |dep1, dep2| 
            dep1.posts.count_of_vacants <=> dep2.posts.count_of_vacants
        }
    end

    def add_note note
        if !(@deps.include? note)
            @deps.push note
        end
    end

    def delete_note note
        if @note == note
            @note = nil
            @index_note = -1
        end
        @deps.delete note
    end

    def choose_note note
        @index_note = -1
        @note = nil
        @deps.each_with_index { |el, i| if el == note then @index_note = i end }
        if @index_note == -1
            "NOTE IS NOT EXIST"
        else
            @note = note
            "NOTE #{@note} ON #{@index_note} POSITION WAS CHOSE"
        end
    end

    def get_note
        if @index_note != -1
            @note
        end
    end

    def change_note note
        prev = @deps[@index_note]
        @deps[@index_note] = note
        @note = note
        "#{prev} WAS CHANGED TO #{@note}"
    end

    def serialize
        if @index_note != -1
            #return YAML.dump @note
            @note.serialize
        end
    end

    def self.deserialize file = File.read('2.yml')
        #return YAML.load yaml
        Department.deserialize file
    end

    def to_hash
        hash_list = []
        @deps.each { |dep|
            hash_list.push dep.to_hash 
        }
        hash_list
    end

    def write_to_yml path = 'read2.yml'
        File.open(path, 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.read_from_yml file = File.read('read2.yml')
        sets = YAML.load file
        deps = []
        sets.each { |set|
            posts = []
            set[:posts].each { |post|
                posts.push Post.new post[:department], post[:name], post[:price], post[:vacant]
            }
            post_list = Post_list.new *posts
            deps.push Department.new set[:name], set[:phone], set[:duties], post_list
        }
        deps
    end
end

#dep1 = Department.new "Google", "+79997776655", "1", "2"
#dep2 = Department.new "Yandex", "+75553332211", "3"
#dep3 = Department.new "Alphabet", "+98908908907", "7", "8"
#dep4 = Department.new "Beta", "+39034654545", "11", "12"
#deps = Department_list.new dep1, dep2, dep3, dep4

#deps.choose_note dep1
#puts "NOTE\n"
#puts deps.get_note
#deps.serialize # сериализуем выбранный
#dep = Department_list.deserialize # десериализуем из файла
#puts "DESERIALIZE\n"
#puts dep
#puts "\n"
#puts "SORTED\n"
#puts deps.sort

# 2
#puts "\n"
#puts "READ FROM TXT\n"
#deps = Department.read_from_txt
#puts deps
#Department.write_to_txt *deps
##puts "READ FROM YML\n"
##deps.write_to_yml
##puts Department_list.read_from_yml

# 4
class Post # должность
    attr_accessor :department # отдел
    attr_accessor :name # название
    attr_accessor :price # оклад
    attr_accessor :vacant # вакантна или нет

    def initialize department, name, price, vacant
        @department = department
        @name = name
        @price = price
        @vacant = vacant
    end

    def to_s
        "Отдел: #{@department}\n" +
        "Название: #{@name}\n" +
        "Оклад: #{@price}\n" +
        "Вакантна: #{@vacant ? "да" : "нет"}\n\n"
    end

    def to_hash
        {
            :department => @department,
            :name => @name,
            :price => @price,
            :vacant => @vacant
        }
    end

    def serialize
        File.open('read5.yml', 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.deserialize file = File.read('read5.yml')
        set = YAML.load file
        self.new set[:department], set[:name], set[:price], set[:vacant]
    end
end

class Post_list
    attr_accessor :posts
    attr_reader :note
    attr_reader :index_note

    def initialize *posts
        @posts = posts
    end

    def to_s
        s = ""
        @posts.each { |post|
            s = s + post.to_s
        }
        s
    end

    def sort
        posts.sort! { |post1, post2| post1.name <=> post2.name }
    end

    def add_note note
        if !(@posts.include? note)
            @posts.push note
        end
    end

    def delete_note note
        if @note == note
            @note = nil
            @index_note = -1
        end
        @posts.delete note
    end

    def choose_note note
        @index_note = -1
        @note = nil
        @posts.each_with_index { |el, i| if el == note then @index_note = i end }
        if @index_note == -1
            "NOTE IS NOT EXIST"
        else
            @note = note
            "NOTE #{@note} ON #{@index_note} POSITION WAS CHOSE"
        end
    end

    def get_note
        if @index_note != -1
            @note
        end
    end

    def change_note note
        prev = @posts[@index_note]
        @posts[@index_note] = note
        @note = note
        "#{prev} WAS CHANGED TO #{@note}"
    end

    def to_hash
        hash_list = []
        @posts.each { |post|
            hash_list.push post.to_hash 
        }
        hash_list
    end

    def write_to_yml path = 'read5.yml'
        File.open(path, 'w') do |file|
            YAML.dump(to_hash, file)
        end
    end

    def self.read_from_yml file = File.read('read5.yml')
        sets = YAML.load file
        posts = []
        sets.each { |set|
            posts.push Department.new set[:department], set[:name], set[:price], set[:vacant]
        }
        posts
    end

    def count_of_vacants
        count = 0
        posts.each { |post|
            if (post.vacant)
                count += 1
            end
        }
        count
    end
end

post1 = Post.new "Google", "директор", 1750, false
post2 = Post.new "Google", "сотрудник", 10, true
post3 = Post.new "Yandex", "директор", 2750, false
post4 = Post.new "Yandex", "сотрудник", 20, false
posts1 = Post_list.new post1, post2
posts2 = Post_list.new post3, post4
#puts posts.posts

# 5
dep1 = Department.new "Google", "+79997776655", ["1", "2"], posts1
dep2 = Department.new "Yandex", "+75553332211", ["3"], posts2
deps = Department_list.new dep1, dep2
deps.write_to_yml
gg = Department_list.read_from_yml
puts deps.deps[0].get_data