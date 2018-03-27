["0x0","0x1","0x2","0x3","0x4","0x5","0x6","0x7","0x8","0x9"], 1

["0xca35b7d915458ef540ade6068dfe2f44e8fa733c", "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db", "0x583031d1113ad414f02576bd6afabfb302140225", "0xdd870fa1b7c4700f2bd7f44238821c26f7392148"], 1

pragma solidity ^0.4.11;

contract BauCu {
    struct ngheSi {
        address ten;
        int8 soPhieu;
    }
    event SoDuHopDong(uint256 soDu);
    ngheSi[] public danhSachNgheSi;
    ngheSi[] public danhSachNguoiChienThang;
    bool daKetThuc = false;
    uint256 public thoiDiemKetThuc;
    int8 public soPhieuNguoiChienThang = 0;
    address diaChiHopDong = this; 
    
    function BauCu(address[] nhapNgheSi, uint256 thoiGianBauChon) {
        for (uint i = 0; i < nhapNgheSi.length; i++) {
            danhSachNgheSi.push(ngheSi({
                ten: nhapNgheSi[i],
                soPhieu: 0
            }));
        }
        thoiDiemKetThuc = now + thoiGianBauChon * 1 minutes;
    }
    
    modifier TrongQuaTrinhBauChon() {
        if (now <= thoiDiemKetThuc) {
            _;
        }
        else revert();
    } 
    
    function bauChonNgheSi(uint8 tenNgheSi) public payable TrongQuaTrinhBauChon {
        require(msg.value == 10 ether);
        danhSachNgheSi[tenNgheSi].soPhieu += 1;
    }
    
    modifier SauQuaTrinhBauChon() {
        require (!daKetThuc);
        if (now > thoiDiemKetThuc) {
            _;
            daKetThuc = true;
        } 
    }
    
    function timNguoiChienThang() public SauQuaTrinhBauChon {
        uint256 soDuHopDong;
        for (uint i = 0; i < danhSachNgheSi.length; i++) {
            if (soPhieuNguoiChienThang < danhSachNgheSi[i].soPhieu) {
                soPhieuNguoiChienThang = danhSachNgheSi[i].soPhieu;
            }
        }
        for (uint j = 0; j < danhSachNgheSi.length; j++) {
            if (soPhieuNguoiChienThang == danhSachNgheSi[j].soPhieu) {
                danhSachNguoiChienThang.push(danhSachNgheSi[j]); 
            }
        }
        soDuHopDong = diaChiHopDong.balance;
        SoDuHopDong(diaChiHopDong.balance); 
        for (uint k = 0; k < danhSachNguoiChienThang.length; k++) {
            danhSachNguoiChienThang[k].ten.transfer(soDuHopDong/danhSachNguoiChienThang.length);
        }
        SoDuHopDong(diaChiHopDong.balance);
    }
}