require 'http'
require 'colorize'
require 'json'

def red
  "\e[31m"
end

def reset
  "\e[0m"
end


logo="""
______ _   _______ _____ _   _ _____
| ___ \ | | | ___ \_   _| \ | |_   _|
| |_/ / | | | |_/ / | | |  \| | | |
|    /| | | | ___ \ | | | . ` | | |
| |\ \| |_| | |_/ /_| |_| |\  | | |
\_| \_|\___/\____/ \___/\_| \_/ \_/

""".colorize(:magenta)
puts logo
puts "Tool made by #{red}Flame#{reset} \nThis tool is shitty btw."

class Phonelookup
  def self.whatsapp?(number)
    demor=number.include?(' ') ? number.delete(' ') : number
    goddamn = HTTP.get("https://wa.me/#{demor}")
    goddamn.status.success?
  end

  def self.general_info(number)
    g=number.delete(' ').delete('+')
    s=HTTP.get("https://api.telnyx.com/anonymous/v2/number_lookup/#{g}")
    s.body.to_s
  end
end

class Email
  def self.lookup(mail, apikey)
    r=HTTP.get("https://api.hunter.io/v2/email-verifier?email=#{mail}&api_key=#{apikey}")
    puts "Results: \n#{r.parse}"
  end
end

class Ip
  def self.lookup(ip)
    url = "https://ipwhois.app/json/#{ip}"
    response = HTTP.get(url)
    body_string = response.body.to_s
    puts body_string.gsub(",", ",\n")
  end
end

class Social
  def self.search(user)
    socials = [
      "https://github.com/#{user}",
      "https://instagram.com/#{user}",
      "https://facebook.com/#{user}",
      "https://replit.com/@#{user}",
      "https://doxbin.com/upload/#{user}"
    ]

    puts "Checking username..."
    socials.each do |site|
      response = HTTP.get(site)

      if response.status.success?
        puts "\nUsername found on #{site}!"
        puts site
      else
      end
    end
  end
end

class Bin #Not sure if this works cuz I wasn't able to test it tho
  def self.lookup(bin, apikey)
    r=HTTP.get("https://api.bintable.com/v1/#{bin}?api_key=#{apikey}")
    puts "Results: \n#{r.parse}"
  end
end


def social_lookup
  print "\nusername: "
  target = gets.chomp
  Social.search(target)
end

def num
  print "\nInsert number: "
  zioeren = gets.chomp
  puts "\nGeneral info:"
  puts Phonelookup.general_info(zioeren)
  puts "\nWhatsapp: #{Phonelookup.whatsapp?(zioeren)}"
end

def email
  print "\nType the E-Mail of the target: "
  sexmail = gets.chomp
  print "\nInsert your apikey: "
  apiki = gets.chomp
  Email.lookup(sexmail, apiki)
end


def ipgrabberer
  print "\nType here the IP address: "
  ippì = gets.chomp
  sex = Ip.lookup(ippì.gsub(" ", ""))
  puts sex
end

def binlookup
  print "\nInsert here the BIN: "
  cestino = gets.chomp
  print "\nInsert here the Api-Key: "
  chiaveapi = gets.chomp
  Bin.lookup(cestino, chiaveapi)
end

puts """
1 - username
2 - email
3 - number
4 - IP lookup
5 - BIN lookup
6 - exit
""".colorize(:red)

def options
  print "\nChoose one: "
  opzioni = gets.chomp
  case opzioni
  when "1"
    social_lookup
  when "2"
    email
  when "3"
    num
  when "4"
    ipgrabberer
  when "5"
    binlookup
  when "6"
    exit
  else
    puts "You selected a wrong option."
  end
end
options
