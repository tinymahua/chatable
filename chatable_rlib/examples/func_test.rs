use std::process::Command;
use rust_decimal::dec;
use chatable_lib::api::table_file::{meta_table_file, stats_file};

pub fn main() {
    let csv_file = "C:\\Users\\Maple\\Desktop\\TMP\\tables\\1.csv".to_string();
    let exc_file = "C:\\Users\\Maple\\Desktop\\TMP\\tables\\1.xlsx".to_string();
    // get_meta_table_file().unwrap();

    // get_stats_file(csv_file.clone()).unwrap();
    // get_stats_file(exc_file.clone()).unwrap();
    // run_exe().unwrap();
    dec_test().unwrap();
}


fn get_meta_table_file(path: String) -> anyhow::Result<()>{
    let v = meta_table_file(path).unwrap();
    println!("Meta: {:?}", v);
    Ok(())
}

fn get_stats_file(path: String) -> anyhow::Result< ()>{
    let v = stats_file(path).unwrap();
    println!("Stats: {:?}", v);
    Ok(())
}

fn run_exe() -> anyhow::Result< ()>{
    let path = "D:\\CodeHome\\fr_wpkit\\build\\windows\\x64\\runner\\Debug\\fr_wpkit.exe";
    let output = Command::new("cmd").args(vec!["/c", path]).output().expect("Failed to run exe");
    println!("{:?}", output);
    Ok(())
}

fn dec_test() -> anyhow::Result<()>{
    let n = 100;
    let d = dec!(n);
    println!("Dec: {:?}", d);
    Ok(())
}