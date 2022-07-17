# -----------------------------------------------------------------------
# Not depend on website and environment
# -----------------------------------------------------------------------


# -----------------------------------------------------------------------
# Only depend on environment
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------
# Data common
# -----------------------------------------------------------------------
GROUP_SUBJECT = [
    {code: 'th1', name: 'Lý - Hoá - Sinh'},
    {code: 'th2', name: 'Sử - Địa - Giáo dục Kinh tế - Pháp luật'},
    {code: 'th3', name: 'Lý - Tin Học - Công nghệ'}
]

THEMATIC_GROUP = [
    {code: 'cd1.1', name: 'Toán - Lý - Hóa', key: 'th1'},
    {code: 'cd1.2', name: 'Toán - Lý - Ngoại ngữ', key: 'th1'},
    {code: 'cd1.3', name: 'Toán - Hóa - Sinh', key: 'th1'},
    {code: 'cd1.4', name: 'Toán - Ngữ Văn - Ngoại ngữ', key: 'th1'},

    {code: 'cd2.1', name: 'Ngữ Văn - Sử - Địa', key: 'th2'},
    {code: 'cd2.2', name: 'Toán - Ngữ Văn - Ngoại ngữ', key: 'th2'},
    {code: 'cd2.3', name: 'Sử - Địa - KTPL', key: 'th2'},

    {code: 'cd3.1', name: 'Toán - Lý - Tin', key: 'th3'}
]

ELECTIVE_SUBJECT_ONE = [
    {code: 'tc1.1.1', name: 'Sử', key: 'th1'},
    {code: 'tc1.1.2', name: 'Địa', key: 'th1'},
    {code: 'tc1.1.3', name: 'Giáo dục Kinh tế - Pháp luật', key: 'th1'},

    {code: 'tc2.1.1', name: 'Lý', key: 'th2'},
    {code: 'tc2.1.2', name: 'Hóa', key: 'th2'},
    {code: 'tc2.1.3', name: 'Sinh', key: 'th2'},

    {code: 'tc3.1.1', name: 'Sử', key: 'th3'},
    {code: 'tc3.1.2', name: 'Địa', key: 'th3'},
    {code: 'tc3.1.3', name: 'Giáo dục Kinh tế - Pháp luật', key: 'th3'}
]

ELECTIVE_SUBJECT_TWO = [
    {code: 'tc1.2.1', name: 'Tin học', key: 'th1'},
    {code: 'tc1.2.2', name: 'Công nghệ (KTCN)', key: 'th1'},
    {code: 'tc1.2.3', name: 'Âm nhạc', key: 'th1'},
    {code: 'tc1.2.4', name: 'Mỹ thuật', key: 'th1'},

    {code: 'tc2.2.1', name: 'Tin học', key: 'th2'},
    {code: 'tc2.2.2', name: 'Công nghệ (KTCN)', key: 'th2'},
    {code: 'tc2.2.3', name: 'Âm nhạc', key: 'th2'},
    {code: 'tc2.2.4', name: 'Mỹ thuật', key: 'th2'},

    {code: 'tc3.2.1', name: 'Hóa', key: 'th3'},
    {code: 'tc3.2.2', name: 'Sinh', key: 'th3'},
    {code: 'tc3.2.3', name: 'Âm nhạc', key: 'th3'},
    {code: 'tc3.2.4', name: 'Mỹ thuật', key: 'th3'},
    {code: 'tc3.2.5', name: 'Sử', key: 'th3'},
    {code: 'tc3.2.6', name: 'Địa', key: 'th3'},
    {code: 'tc3.2.7', name: 'Giáo dục Kinh tế - Pháp luật', key: 'th3'}
]

ALTERNATIVE_SUBJECT = [
    {code: 'tt1.3.1', name: 'Tin học', key: 'th1'},
    {code: 'tt1.3.2', name: 'Công nghệ (KTCN)', key: 'th1'},

    {code: 'tt2.3.1', name: 'Tin học', key: 'th2'},
    {code: 'tt2.3.2', name: 'Công nghệ (KTCN)', key: 'th2'},

    {code: 'tt3.3.1', name: 'Hóa', key: 'th3'},
    {code: 'tt3.3.2', name: 'Sinh', key: 'th3'},
    {code: 'tt3.3.3', name: 'Sử', key: 'th3'},
    {code: 'tt3.3.4', name: 'Địa', key: 'th3'},
    {code: 'tt3.3.5', name: 'Giáo dục Kinh tế - Pháp luật', key: 'th3'}
]

LIST_SCHOOL = [
    'Trường THCS Phan Bội Châu',
    'PTDL HERMANN GMEINER',
    'TH-THCS -THPT TRÍ TUỆ VIỆT',
    'TH, THCS VÀ THPT CHU VĂN AN',
    'TH, THCS VÀ THPT QUỐC TẾ Á CHÂU',
    'THCS ÂU LẠC',
    'THCS BÌNH HƯNG HÒA',
    'THCS BÌNH TRỊ ĐÔNG',
    'THCS BÌNH TRỊ ĐÔNG A',
    'THCS ĐẶNG TRẦN CÔN',
    'THCS ĐỒNG ĐEN',
    'THCS ĐỒNG KHỞI',
    'THCS DƯƠNG BÁ TRẠC',
    'THCS HÀ HUY TẬP',
    'THCS HỒ VĂN LONG',
    'THCS HOÀNG HOA THÁM',
    'THCS HÙNG VƯƠNG',
    'THCS HUỲNH VĂN NGHỆ',
    'THCS LÊ ANH XUÂN',
    'THCS LÊ LỢI',
    'THCS LÝ THƯỜNG KIỆT',
    'THCS NGÔ QUYỀN',
    'THCS NGÔ SĨ LIÊN',
    'THCS NGUYỄN ẢNH THỦ',
    'THCS NGUYỄN GIA THIỀU',
    'THCS NGUYỄN HUỆ',
    'THCS NGUYỄN TRÃI',
    'THCS NGUYỄN VĨNH NGHIỆP',
    'THCS PHẠM VĂN CHIÊU',
    'THCS PHAN BỘI CHÂU',
    'THCS PHAN CÔNG HỚN',
    'THCS PHÚ ĐỊNH',
    'THCS TÂN THỚI HÒA',
    'THCS THOẠI NGỌC HẦU',
    'THCS TÔN THẤT TÙNG',
    'THCS TRẦN HUY LIỆU',
    'THCS TRẦN QUANG KHẢI',
    'THCS TRẦN QUỐC TOẢN',
    'THCS TRẦN VĂN QUANG',
    'THCS TRƯỜNG CHINH',
    'THCS VĨNH LỘC A',
    'THCS VĨNH LỘC B',
    'THCS VÕ THÀNH TRANG',
    'THCS VÕ VĂN TẦN',
    'THCS VÕ VĂN VÂN',
    'TIH, THCS VÀ THPT LÊ THÁNH TÔNG'
]

SCHOOL_TYPE = ['Dân lập', 'Công lập', 'Bán công']

EXERCISE_RESULT = ['Đạt', 'Không đạt']

RANKED_ACADEMIC = ['Giỏi', 'Khá', 'Trung bình', 'Yếu', 'Kém']

CONDUCT = ['Tốt', 'Khá', 'Trung bình', 'Yếu']