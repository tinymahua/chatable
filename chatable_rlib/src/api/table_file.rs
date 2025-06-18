use rsv_lib;

#[derive(Debug)]
pub struct TableFileMeta {
    pub path: String,
    pub rows_count: usize,
    pub size: u64,
    pub titles:  Vec< String>,
}

pub fn meta_table_file(path: String) -> anyhow::Result<TableFileMeta> {
    let size_result = rsv_lib::file_size(&path).expect("get file size error").unwrap();
    println!("file size: {:?}", size_result);
    let size = size_result.data[0].first().unwrap().to_string().parse::<u64>().unwrap();

    let count_result = rsv_lib::file_count(&path, false,  0).expect("get file count error").unwrap();
    println!("file count: {:?}", count_result);
    let count = count_result.data[0].first().unwrap().to_string().parse::<usize>().unwrap();

    let headers_result = rsv_lib::file_headers(&path, ',', '"', 0).expect("get file headers error").unwrap();
    println!("file headers: {:?}", headers_result);
    let headers = headers_result.data.iter().map(|x| x.first().unwrap().to_string()).collect();

    Ok(TableFileMeta {
        path,
        rows_count: count,
        size,
        titles: headers,
    })
}


pub fn stats_file(path: String) -> anyhow::Result<(Vec<String>, Vec<Vec<String>>)> {
    let rsv_lib::ResultData {header, data} = rsv_lib::file_stats(&path, ',', '"', false, "".to_string(), 0).expect("get file stats error").unwrap();
    println!("file stats: {:?}\n{:?}", header, data);
    Ok((header, data))
}
