require "sensi"
require "influxdb"
require_relative './secrets.rb'

class CollectStat
  def main
    device = connect(ENV['sensi_user'],ENV['sensi_pw'])
    db_connect = connect_db(ENV['db'])

    unless device.nil? || db_connect.nil?
      thermostat_stats = collect_stats(device)

      unless thermostat_stats.nil?
          send_stats(thermostat_stats,db_connect)

      end
    end
  end

  def connect (user, pw)
    thermostat = Sensi::Thermostat.new(user, pw)
    thermostat.connect
    return thermostat
  rescue
    return nil
  end

  def connect_db (db)
    influxdb = InfluxDB::Client.new db
    return influxdb
  rescue
    return nil
  end

  def collect_stats(thermostat)
    mode = thermostat.system_mode
    temp = thermostat.system_temperature
    humidity = thermostat.humidity
    on = thermostat.system_on?
    fan_running = thermostat.system_fan_on?
    running = thermostat.system_active?
    runningTime = thermostat.active_time


    stats = {
      "mode" => mode,
      "temp" => temp,
      "humidity" => humidity,
      "SystemOn" => on.to_s,
      "fan_running" => fan_running.to_s,
      "running" => running.to_s,
      "runningTime" => runningTime
    }
    stats
  end

  def send_stats(stats,db)
    name = 'thermostat'

    stats.each do |key,value|
      data = {values: { value: "#{value}" },tags:{ stat: "#{key}",location: "upstairs" }}
      db.write_point(name, data)
      #puts data
    end
  end

end

CollectStat.new.main
