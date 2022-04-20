# 1.1
def f11
    puts "Hello World"
end

# 1.2
def f12(name = "World")
    puts "Hello #{name}"
end

# 1.3
# через if
def f13if
    puts "Какой у тебя любимый язык?"
    lang = gets.chomp
    if lang == "ruby"
        puts "крутой"
    else
        puts "лох"
    end
end

# через case
def f13sw
    puts "Какой у тебя любимый язык?"
    lang = gets.chomp
    case lang
    when "ruby"
        puts "крутой"
    else
        puts "лох"
    end
end

# 1.4
def f14
    puts "ruby -> "
    com1 = gets.chomp
    eval(com1)
    puts "sys -> "
    com2 = gets.chomp
    system(com2)
end

# 2.1
def f21(num = 0)
    num = num.abs
    if num < 10
        puts "sum => #{num}"
    else
        sum = 0
        while num != 0 do
            sum += num % 10
            num /= 10
        end
        puts "sum => #{sum}"
    end
end

# 2.2
def f22sum(num = 0)
    num = num.abs
    if num < 10
        return num
    else
        sum = 0
        while num != 0 do
            sum += num % 10
            num /= 10
        end
        return sum
    end
end

def f22min(num = 0)
    num = num.abs
    if num < 10
        return num
    else
        min = 10
        while num != 0 do
            if num % 10 < min
                min = num % 10
            end
            if min == 0
                break
            end
            num /= 10
        end
        return min
    end
end

def f22max(num = 0)
    num = num.abs
    if num < 10
        return num
    else
        max = -1
        while num != 0 do
            if num % 10 > max
                max = num % 10
            end
            if max == 9
                break
            end
            num /= 10
        end
        return max
    end
end

def f22prod(num = 0)
    num = num.abs
    if num < 10
        return num
    else
        prod = 1
        while num != 0 do
            prod *= num % 10
            if prod == 0
                break
            end
            num /= 10
        end
        return prod
    end
end

# 2.3 (вариант 2)
def f23simple(num1, num2)
    if num1 == num2 then
        return false
    end
    min = if num1 < num2 then num1 else num2 end
    if min == 1 then
        return true
    end
    if (num1 + num2) % 2 == 0 && min == 2 then
        return false
    end
    del = 2
    while del != min + 1 do
        if (num1 % del == 0) && (num2 % del == 0) then
            return false
        end
        del += 1
    end
    return true
end

def f23m1(num)
    count = 0
    del = 1
    while del != num do
        if f23simple(num, del)
            count += 1
        end
        del += 1
    end
    return count
end

def f23m2(num)
    sum = 0
    while num != 0 do
        if (num % 10) % 3 == 0
            sum += num % 10
        end
        num /= 10
    end
    return sum
end

def f23count(num)
    num = num.abs
    if num < 10
        return 1
    end
    count = 0
    while num != 0 do
        count += 1
        num /= 10
    end
    return count
end

# наибольший делитель, взаимно простой с количеством цифр числа
def f23m3(num)
    del = num - 1
    count = f23count(num)
    while del != 0 do
        if f23simple(del, count)
            return del
        end
        del -= 1
    end
    return -1
end

def f23(num)
    puts "1 | 2 | 3 ?"
    arg = gets.chomp
    arg = arg == "" ? -1 : arg.to_i
    case arg
    when 1
        puts "count => #{f23m1 num}"
    when 2
        puts "sum => #{f23m2 num}"
    when 3
        puts "del => #{f23m3 num}"
    else
        puts "Hello World"
    end
end

# 3.1
def f31min(*list)
    min = list.at(0)
    for el in list do
        if el < min
            min = el
        end
    end
    return min
end

def f31max(*list)
    max = list[0]
    list.each { |el| if el > max then max = el end }
    return max
end

def f31sum(*list)
    sum = 0
    list.each { |el| sum += el }
    return sum
end

def f31prod(*list)
    prod = 1
    list.each { |el| prod *= el }
    return prod
end

def f32method(method, *list)
    case method
    when 1
        puts "min => #{f31min(*list)}"
    when 2
        puts "max => #{f31max(*list)}"
    when 3
        puts "sum => #{f31sum(*list)}"
    when 4
        puts "prod => #{f31prod(*list)}"
    end
end

def f32
    puts "1 {min} | 2 {max} | 3 {sum} | 4 {prod} ?"
    method = gets.chomp.to_i
    puts "k {keyboard} | f {file} ?"
    kof = gets.chomp
    # path = kof == "f" ? gets.chomp : ""
    list = []
    case kof
    when "k"
        str = gets.chomp
        str.split.each { |el| list.push el.to_i }
    when "f"
        file = File.new("f32.txt", "r:UTF-8")
        content = file.read
        content.split.each { |el| list.push el.to_i }
    end
    f32method(method, *list)
end

# 4.2
def f42
    list = []
    puts "list ?"
    str = gets.chomp
    str.split.each { |el| list.push el.to_i }
    min = list[0]
    imin = 0
    list.each_with_index do |el, i|
        if el < min then
            min = el
            imin = i
        end
    end
    puts "index of #{min} => #{imin}"
end

# 4.14
def f414
    list = []
    puts "list ?"
    str = gets.chomp
    str.split.each { |el| list.push el.to_i }
    count = 0
    puts "a (via 0) ?"
    a = gets.chomp.to_i
    puts "b (via 0) ?"
    b = gets.chomp.to_i
    size = list.length
    if a >= size - 1
        count = 0
    elsif b >= size + 1
        a >= -1 ? count = size - a - 1 : count = size
    else
        a >= -1 ? count = b - a - 1 : count = b
    end
    puts "count => #{count}"
end

# 4.26
def f426
    list = []
    puts "list ?"
    str = gets.chomp
    str.split.each { |el| list.push el.to_i }
    count = 0
    min = list[0]
    imin1 = 0
    imin2 = 0
    list.each_with_index do |el, i|
        if el < min
            min = el
            imin1 = i
        end
    end
    list.reverse.each_with_index do |el, i|
        if el == min
            imin2 = list.length - i - 1
            break
        end
    end
    puts "[#{imin1}, #{imin2}]"
    if (imin1 - imin2).abs <= 1
        count = 0
    else
        count = imin2 - imin1 - 1
    end
    puts "count => #{count}"
end

# 4.38
def f438
    list = []
    puts "list ?"
    str = gets.chomp
    str.split.each { |el| list.push el.to_i }
    count = 0
    puts "a ?"
    a = gets.chomp.to_i
    puts "b ?"
    b = gets.chomp.to_i
    list.each { |el| if a <= el && el <= b then count += 1 end }
    puts "count => #{count}"
end

# 4.50
def f450
    path = "f450.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    list1 = []
    list2 = []
    lines[0].split.each { |el| list1.push el.to_i }
    lines[1].split.each { |el| list2.push el.to_i }
    list = (list1 | list2) - (list1 & list2)
    puts list
end

# 5.1.2
# abDc норм
# abca не норм
def f5_1_2
    puts "string ?"
    str = gets.chomp
    cur = str[0]
    flag = true
    str.each_char do |c|
        if !(c >= 'a' && c <= 'z')
            next
        elsif c >= cur
            cur = c
        else
            flag = false
            break
        end
    end
    flag ? (puts "по возрастанию") : (puts "не по возрастанию")
end

# 5.1.10
def f5_1_10
    puts "string ?"
    str = gets.chomp
    count = str.count "A"
    puts "count => #{count}"
end

# 5.1.17
def f5_1_17
    file = File.new("f5_1_17.txt", "r:UTF-8")
    content = file.read
    name = content.split('\\').last.split('.').first
    puts "name => #{name}"
end

# 5.2
def f5_2
    file = File.new("f5_2.txt", "r:UTF-8")
    content = file.read
    dates = content.scan(/[0-9]{2} [а-я]+ [0-9]{4}/)
    puts "dates => #{dates}"
end

# 5.3.2
def f5_3_2
    puts "string ?"
    str = gets.chomp
    chars = str.scan /[a-z]{1}/
    puts "chars => #{chars}"
end

# 5.3.10
def f5_3_10
    puts "string ?"
    str = gets.chomp
    count = str.scan(/[a-z]{1}/).uniq.count
    puts "count => #{count}"
end

# 5.3.17
def f5_3_17
    file = File.new("f5_1_17.txt", "r:UTF-8")
    content = file.read
    name = content.split('\\').last.split('.').first
    puts "name => #{name}"
end

# 6.1
def f6_1
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    lines.sort! { |a, b| a.length <=> b.length }
    puts "lines => #{lines}"
end

# 6.2
def f6_2
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    words = []
    lines.each { |line| words.push line.split }
    words.sort! { |a, b| b.length <=> a.length }
    puts "words => #{words}"
end

# 6.3.2
def f6_3_2
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    codes = []
    lines.each { |line| codes.push [line, (line.codepoints.sum / line.length)] }
    codes.sort! { |a, b| a[1] <=> b[1] }
    puts "codes => #{codes}"
end

# 6.3.4
def f6_3_4
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    codes = []
    lines.each { |line| codes.push [line, (line.codepoints.sum / line.length)] }
    code01 = codes[0][1]
    codes.each { |code| code[1] = (code[1] - code01)**2 }
    codes.sort! { |a, b| a[1] <=> b[1] }
    puts "codes => #{codes}"
end

# 6.3.7
def f6_3_7
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    difs = []
    reg_gl = /[аоуыэяёюиеАОУЫЭЯЁЮИЕ]/
    reg_sogl = /[бвгджзйклмнпрстфхцчшщБВГДЖЗЙКЛМНПРСТФХЦЧШЩ]/
    lines.each do |line|
        gl_sogl = 0
        sogl_gl = 0
        for i in 0..(line.length - 2) do
            if line[i][reg_gl] != nil && line[i + 1][reg_sogl] != nil
                gl_sogl += 1
            elsif line[i][reg_sogl] != nil && line[i + 1][reg_gl] != nil
                sogl_gl += 1
            end
        end
        difs.push [line, (gl_sogl - sogl_gl).abs]
    end
    difs.sort! { |a, b| a[1] <=> b[1] }
    puts "difs => #{difs}"
end

# 6.3.11
# вероятность появления каждого символа в строке
# максимальный вес символа в строке
# дисперсия вероятности и символа
def f6_3_11
    path = "f6_1.txt"
    file = File.new(path, "r:UTF-8")
    lines = file.readlines
    lines.each { |line| line.chomp! }
    devs = []
    lines.each do |line|
        max = line.codepoints.max
        uniq = line.split('').uniq
        chances = [] # вероятности
        uniq.each do |el|
            chances.push [el, (line.count(el) / line.length)]
        end
        m_for_x2 = 0 # m(x^2)
        chances.each do |el|
            m_for_x2 += ((el[0].ord)**2) * el[1]
        end
        m_for_x_2 = 0 # (m(x))^2
        chances.each do |el|
            m_for_x_2 += el[0].ord * el[1]
        end
        m_for_x_2 **= 2
        disp_x = m_for_x2 - m_for_x_2
        standard_deviation = (max - disp_x) ** 2
        devs.push [line, standard_deviation]
    end
    devs.sort! { |a, b| a[1] <=> b[1] }
    puts "devs => #{devs}"
end

